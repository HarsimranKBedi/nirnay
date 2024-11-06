import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

  
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(), 
        );
      },
    );

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;

       
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop(); 

        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
                  'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content:
                  'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        Navigator.of(context).pop(); 
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'Error occurred using Google Sign-In. Try again.',
          ),
        );
      }
    } else {
     
      Navigator.of(context).pop();
    }

    return user;
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}
