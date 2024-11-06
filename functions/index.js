const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.dailyReminderCheck = functions.pubsub
    .schedule("every 24 hours")
    .onRun(async (context) => {
      const now = admin.firestore.Timestamp.now();

      const remindersSnapshot = await db.collection("reminders")
          .where("reminderTime", "<=", now)
          .where("isDone", "==", false)
          .get();

      if (!remindersSnapshot.empty) {
        remindersSnapshot.forEach(async (reminderDoc) => {
          const reminderData = reminderDoc.data();
          await sendNotification(
              reminderData.userId,
              reminderData.title,
              reminderData.reminderTime.toDate(),
          );
          await reminderDoc.ref.update({isDone: true});
        });
      }
      return null;
    });

/**
 * Send a notification to the user using Firebase Cloud Messaging (FCM).
 *
 * @param {string} userId - The ID of the user to send the notification to.
 * @param {string} title - The title of the reminder.
 * @param {Date} reminderTime - The time of the reminder.
 */
async function sendNotification(userId, title, reminderTime) {
  const userDoc = await db.collection("users").doc(userId).get();
  const userToken = userDoc.data().deviceToken;

  const message = {
    notification: {
      title: "Reminder!",
      body: `${title} at ${reminderTime.toLocaleTimeString()}`,
    },
    token: userToken,
  };

  try {
    await admin.messaging().send(message);
    console.log("Notification sent successfully");
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

