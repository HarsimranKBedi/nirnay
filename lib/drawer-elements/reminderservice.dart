import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<void> addReminder(String userId, DateTime reminderDate, String cropName) async {
    try {
      await _firestore.collection('reminders').add({
        'userId': userId,
        'reminderDate': reminderDate,
        'cropName': cropName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding reminder: $e');
    }
  }

  // Get reminders for a user
  Stream<QuerySnapshot> getReminders(String userId) {
    return _firestore
        .collection('reminders')
        .where('userId', isEqualTo: userId)
        .orderBy('reminderDate')
        .snapshots();
  }
}
