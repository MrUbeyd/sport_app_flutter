import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/Screens/Login/login_screen.dart';
import 'package:sport_app/Screens/Signup/components/background.dart';
import 'package:sport_app/Screens/Signup/userNameSelection.dart';
import 'package:sport_app/authentication_service.dart';
import 'package:sport_app/components/already_have_an_account_acheck.dart';
import 'package:sport_app/components/rounded_button.dart';
import 'package:sport_app/components/rounded_input_field.dart';
import 'package:sport_app/components/rounded_input_nameSurname.dart';
import 'package:sport_app/components/rounded_password_field.dart';
import 'package:sport_app/components/snackBar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password, _passwordRepeat, _nameSurname;

  final auth = FirebaseAuth.instance;
  AuthenticationService authenticationService;
  MySnackBars mySnackBars = new MySnackBars();
  @override
  void initState() {
    FirebaseAuth _firebaseAuth;
    authenticationService = new AuthenticationService(_firebaseAuth);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            /*
            SvgPicture.asset(
              "assets/icons/sign-up.svg",
              height: size.height * 0.2,
            ),*/
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
            RoundedInputNameSurnameField(
              hintText: "Name Surname",
              onChanged: (value) {
                setState(() {
                  _nameSurname = value.toUpperCase();
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim().toString();
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  _passwordRepeat = value.trim().toString();
                });
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                if (_password != _passwordRepeat) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(mySnackBars.showSnackBarPasswordError());
                } else {
                  try {
                    await auth
                        .createUserWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((value) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        var userID = value.user.uid;
                        authenticationService.updateUserData(
                            _email, _nameSurname, userID);

                        return UserNameSelection(
                          userID: userID,
                        );
                      }));
                    });
                  } on FirebaseAuthException catch (e) {
                    return e.message;
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
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
