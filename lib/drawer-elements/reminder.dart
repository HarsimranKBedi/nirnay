import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now(); 
  }

  Future<void> _deleteReminder(String formattedDate, String reminderId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String userUID = currentUser.uid;

    
      await _firestore
          .collection('users')
          .doc(userUID)
          .collection('reminders')
          .doc(formattedDate)
          .collection('reminderList')
          .doc(reminderId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set an Event'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                  lastDay: DateTime.utc(DateTime.now().year, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });

                    if (_selectedDay != null) {
                      _showRemindersList(context, _selectedDay!);
                    }
                  },
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                  ),
                ),
                SizedBox(height: 20),
                if (_selectedDay != null)
                  Column(
                    children: [
                      Text(
                        'Selected Date: ${_selectedDay!.day}-${_selectedDay!.month}-${_selectedDay!.year}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedDay != null
          ? FloatingActionButton(
              onPressed: () {
                _showReminderDialog(context, _selectedDay!);
              },
              child: Icon(Icons.add),
              tooltip: 'Add Reminder',
            )
          : null,
    );
  }

  void _showReminderDialog(BuildContext context, DateTime selectedDate) {
    String? reminderTitle;
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Set a Reminder'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Enter Reminder Title'),
                    onChanged: (value) {
                      reminderTitle = value;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Select Time: '),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                        child: Text(selectedTime.format(context)),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (reminderTitle != null) {
                      _saveReminder(selectedDate, reminderTitle!, selectedTime);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Reminder set for ${selectedDate.day}-${selectedDate.month}-${selectedDate.year} at ${selectedTime.format(context)}!'),
                        ),
                      );
                    }
                  },
                  child: Text('Set Reminder'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveReminder(DateTime date, String title, TimeOfDay time) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String userUID = currentUser.uid;

      
      await _firestore
          .collection('users')
          .doc(userUID)
          .collection('reminders')
          .doc(formattedDate)
          .collection('reminderList') 
          .add({
        'title': title,
        'time': '${time.hour}:${time.minute}',
        'date': formattedDate,
      });
    }
  }

  void _showRemindersList(BuildContext context, DateTime selectedDate) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String userUID = currentUser.uid;

     
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('users')
                .doc(userUID)
                .collection('reminders')
                .doc(formattedDate)
                .collection('reminderList')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text('No reminders set for this day.'),
                  ),
                );
              }

             
              List<DocumentSnapshot> reminderDocs = snapshot.data!.docs;

              return Container(
                height: 200,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reminders for ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: reminderDocs.length,
                        itemBuilder: (context, index) {
                          var reminderData = reminderDocs[index].data() as Map<String, dynamic>;
                          String title = reminderData['title'];
                          String time = reminderData['time'];

                          return ListTile(
                            title: Text(title),
                            subtitle: Text('Time: $time'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteReminder(formattedDate, reminderDocs[index].id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }
} 