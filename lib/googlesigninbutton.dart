import 'package:flutter/material.dart';
import 'package:nirnay/firebase-login-signup/googlesignin.dart';

 

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:210,
      height:55,
      child: ElevatedButton(
            style: TextButton.styleFrom(
              // primary: Colors.black, // Text color
              // backgroundColor: Colors.white, // Background color
              elevation: 10,
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              Authentication.signInWithGoogle(context: context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/gfinal.png', 
                  height: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Sign up with Google',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
