import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/Screens/Home/homeScreen.dart';
import 'package:sport_app/Screens/Login/components/background.dart';
import 'package:sport_app/Screens/Login/login_screen.dart';
import 'package:sport_app/authentication_service.dart';
import 'package:sport_app/components/rounded_button.dart';
import 'package:sport_app/components/rounded_input_userName_field.dart';
import 'package:sport_app/components/snackBar.dart';

class ChooseUsername extends StatefulWidget {
  final String userID;
  ChooseUsername({Key key, @required this.userID}) : super(key: key);
  @override
  _ChooseUsernameState createState() => _ChooseUsernameState();
}

class _ChooseUsernameState extends State<ChooseUsername> {
  bool _isUserNameAvailable = false;
  String _userName = "";
  AuthenticationService authenticationService;
  MySnackBars mySnackBars = new MySnackBars();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Choose UserName",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputUserNameField(
              hintText: "UserName",
              onChanged: (value) {
                setState(() {
                  _userName = value.trim();
                });
              },
            ),
            SizedBox(height: size.height * 0.01),
            /*
            RoundedButton(
              text: "Check UserName",
              press: () async {
                setState(() {});
                if (_userName == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      mySnackBars.showSnackBarUserNameNullError());
                } else if (_userName != "") {
                  try {
                    setState(() {});
                    var snapShot = await FirebaseFirestore.instance
                        .collection("userNames")
                        .doc(_userName)
                        .get();

                    if (snapShot.exists) {
                      print("okeyyyyy username taken");
                      ScaffoldMessenger.of(context).showSnackBar(
                          mySnackBars.showSnackBarBool(_isUserNameAvailable));
                      _isUserNameAvailable = false;
                    } else {
                      _isUserNameAvailable = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                          mySnackBars.showSnackBarBool(_isUserNameAvailable));
                      print("noooooooooooo");
                    }
                  } on FirebaseException catch (e) {
                    return e.message;
                  }
                }
              },
            ),
            */
            SizedBox(height: size.height * 0.01),
            RoundedButton(
              text: "Choose UserName",
              press: () async {
                try {
                  if (_userName == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBars.showSnackBarUserNameNullError());
                  } else {
                    var snapShot = await FirebaseFirestore.instance
                        .collection("userNames")
                        .doc(_userName)
                        .get();

                    if (snapShot.exists) {
                      _isUserNameAvailable = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                          mySnackBars.showSnackBarBool(_isUserNameAvailable));
                    } else {
                      _isUserNameAvailable = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                          mySnackBars.showSnackBarBool(_isUserNameAvailable));

                      //usernames table add...
                      CollectionReference userNames =
                          FirebaseFirestore.instance.collection('userNames');
                      await userNames
                          .doc(_userName)
                          .set({"userID": widget.userID});
                      //users table update username value
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userID)
                          .update({"userName": _userName}).then((value) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      });
                    }
                  }
                } on FirebaseException catch (e) {
                  return e.message;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
