import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nirnay/firebase-login-signup/authFunctions.dart';
import 'package:nirnay/googlesigninbutton.dart';
import 'signup_screen.dart'; 
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  bool login = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            login ? 'Login' : 'Sign Up',
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ======== Full Name ========
                if (!login) 
                  TextFormField(
                    key: ValueKey('fullname'),
                    decoration: InputDecoration(hintText: 'Enter Full Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Full Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      fullname = value!;
                    },
                  ),

                // ======== Email ========
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(hintText: 'Enter Email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please Enter valid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),

                // ======== Password ========
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Enter Password'),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Please Enter Password of min length 6';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                SizedBox(height: 30),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        login
                            ? AuthServices.signinUser(email, password, context)
                            : AuthServices.signupUser(email, password, fullname, context);
                      }
                    },
                    child: Text(login ? 'Login' : 'Sign Up'),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      login = !login; 
                    });
                  },
                  child: Text(login
                      ? "Don't have an account? Sign Up"
                      : "Already have an account? Login"),
                ),
                Center(
                    child: SignInScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
