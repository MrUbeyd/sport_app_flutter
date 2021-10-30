import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sport_app/Screens/Home/homeScreen.dart';
import 'package:sport_app/Screens/Login/components/background.dart';
import 'package:sport_app/Screens/Signup/components/or_divider.dart';
import 'package:sport_app/Screens/Signup/components/social_icon.dart';
import 'package:sport_app/Screens/Signup/signup_screen.dart';
import 'package:sport_app/components/already_have_an_account_acheck.dart';
import 'package:sport_app/components/rounded_button.dart';
import 'package:sport_app/components/rounded_input_field.dart';
import 'package:sport_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class _BodyState extends State<Body> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                try {
                  await auth
                      .signInWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((value) {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  });
                } on FirebaseAuthException catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Wrong password or email !!!"),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text("Please try again."),
                          ),
                          actions: [
                            Padding(
                              padding: //padding is an issue must be correct !!!
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        );
                      });
                  return e.message;
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            /*
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
