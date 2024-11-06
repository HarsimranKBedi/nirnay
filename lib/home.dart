import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirnay/cards.dart';
import 'package:nirnay/drawer-elements/alert.dart';
import 'package:nirnay/drawer.dart';
import 'package:nirnay/weather.dart';
import 'heroingredient.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RemindersAlert(context).showReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Krishi Nirnay',
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.brown,
              ),
            ),
            // Icon(Icons.menu_book),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 235, 229, 172),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroIngredient(),
            Padding(
              padding: EdgeInsets.only(right: 25.w, left: 25.w, bottom: 10.w),
              child: Divider(height: 15.h, thickness: 2.w),
            ),
            Designcards(),
            SizedBox(height: 10),
            WeatherScroll(),
            // Timerrecipes(),
            // States(),
            // Miscallenous(),
          ],
        ),
      ),
    );
  }
}
