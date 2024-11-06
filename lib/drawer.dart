import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirnay/drawer-elements/reminder.dart';

class DrawerWidget extends StatelessWidget {
  final List<ListTileData> items = [
    ListTileData(Icons.save, 'Saved Crop Diseases'),
    ListTileData(Icons.upload, 'Set an Event'),
    ListTileData(Icons.exit_to_app, 'LogOut'),
  ];

  @override
  Widget build(BuildContext context) {
   
    User? currentUser = FirebaseAuth.instance.currentUser;
    String userId = currentUser != null ? currentUser.uid : 'demo1'; 

    return Drawer(
      backgroundColor: Color.fromARGB(255, 244, 239, 198),
      semanticLabel: 'Navigation Panel',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  
                  SizedBox(width: 10.w),
                  // Optionally, you can show the user's display name or email here
                  // Expanded(
                  //   child: Text(
                  //     currentUser != null ? currentUser.displayName ?? 'User' : 'Guest',
                  //     style: TextStyle(
                  //       fontSize: 16.sp,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(items[index].icon, color: Colors.black, size: 18.sp),
                title: Text(
                  items[index].title,
                  style: GoogleFonts.roboto(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400),
                ),
                onTap: () async {
                  if (items[index].title == 'Set an Event') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarScreen(), 
                      ),
                    );
                  }
                  if (items[index].title == 'LogOut') {
                    await FirebaseAuth.instance.signOut();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ListTileData {
  final IconData icon;
  final String title;

  ListTileData(this.icon, this.title);
}
