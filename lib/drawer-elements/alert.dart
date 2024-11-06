import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemindersAlert {
  final BuildContext context;

  RemindersAlert(this.context);

  Future<void> showReminders() async {
    
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      
      print("No user is logged in");
      return;
    }

    
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('reminders')
        .get(); 

    
    List<DocumentSnapshot> reminders = snapshot.docs;

    if (reminders.isNotEmpty) {
   
      String remindersContent = reminders.map((doc) {
        return '${doc['title']}: ${doc['time']}'; 
      }).join('\n'); 

      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Reminders'),
            content: Text(remindersContent), 
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
    
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Reminders'),
            content: Text('You have no reminders set.'), 
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
