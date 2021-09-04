import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/Screens/Signup/components/background.dart';
import 'package:sport_app/Screens/userProfile/userProfile.dart';
import 'package:sport_app/authentication_service.dart';
import 'package:sport_app/components/roundedInput.dart';
import 'package:sport_app/components/rounded_button.dart';
import 'package:sport_app/components/snackBar.dart';
import 'package:sport_app/programs.dart';
import 'package:sport_app/workoutForFatBurn.dart';
import 'package:sport_app/workoutForMuscle.dart';
import 'package:sport_app/workoutForProtection.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _weight, _height, _gender = 1, _age;
  String _selectedGender = 'male';
  var waterNeed, _height2;
  double bmi, bodyFat, bmr;
  String _mail, _nameSurname, _userName, _recommendedProgram;

  final auth = FirebaseAuth.instance;
  AuthenticationService authenticationService;
  MySnackBars mySnackBars = new MySnackBars();
  @override
  // ignore: must_call_super
  void initState() {
    FirebaseAuth _firebaseAuth;
    authenticationService = new AuthenticationService(_firebaseAuth);
  }

  var firebaseUser = FirebaseAuth.instance.currentUser;
  var userID;
  _BodyState() {
    userID = firebaseUser.uid;
  }
  //hata var alttaki fonksiyonları kullanamıyoruz yanlış değer dönüyor !!!

  Future<String> getMailCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['email']);
  }

  Future<String> getRecommendedProgramCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['recommendedProgram']);
  }

  Future<String> getUserNameCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['userName']);
  }

  Future<String> getNameSurnameCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['nameSurname']);
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
              "Check Up",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInput(
              hintText: "Weight (kg.)",
              onChanged: (value) {
                setState(() {
                  _weight = int.parse(value);
                });
              },
            ),
            RoundedInput(
              hintText: "Height (cm.)",
              onChanged: (value) {
                setState(() {
                  _height = int.parse(value);
                });
              },
            ),
            RoundedInput(
              hintText: "Age",
              onChanged: (value) {
                setState(() {
                  _age = int.parse(value);
                });
              },
            ),
            Column(
              children: [
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Radio(
                      value: 'male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                          _gender = 1;
                        });
                      },
                    ),
                  ),
                  title: Text('Male'),
                ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Radio(
                      value: 'female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                          _gender = 2;
                        });
                      },
                    ),
                  ),
                  title: Text('Female'),
                ),
              ],
            ),
            RoundedButton(
              text: "Check Up",
              press: () async {
                waterNeed = (0.03 * _weight);
                _height2 = (_height / 100) * (_height / 100); //height(m^2)
                bmi = (_weight / _height2);
                if (_gender == 1) {
                  //male
                  bodyFat = (((1.2 * bmi) + (0.23 * _age) - 16.2));
                  bmr = (66.5 +
                      (13.75 * _weight) +
                      (5.03 * _height) -
                      (6.75 * _age));
                } else {
                  //female
                  bodyFat = ((1.2 * bmi) + (0.23 * _age) - 5.4);
                  bmr = (655.1 +
                      (9.56 * _weight) +
                      (1.85 * _height) -
                      (4.68 * _age));
                }
                if (bmi < 18.5) {
                  _recommendedProgram = "Gain Muscle";
                } else if (bmi < 25 && bmi >= 18.5) {
                  _recommendedProgram = "Protect Your Body";
                } else {
                  _recommendedProgram = "Fat Burn";
                }
                _mail = await getMailCurrentUser(userID);
                _nameSurname = await getNameSurnameCurrentUser(userID);
                _userName = await getUserNameCurrentUser(userID);
                //_recommendedProgram = await getRecommendedProgramCurrentUser(userID);
                try {
                  await authenticationService
                      .updateUserBodyData(
                          _mail,
                          _nameSurname,
                          _userName,
                          _recommendedProgram,
                          waterNeed.toString(),
                          bmi.toString(),
                          bodyFat.toString(),
                          bmr.toString(),
                          userID)
                      .then((value) {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      if (_recommendedProgram == "Gain Muscle") {
                        return WorkoutForMuscle();
                      } else if (_recommendedProgram == "Protect Your Body") {
                        return WorkoutForProtection();
                      } else if (_recommendedProgram == "Fat Burn") {
                        return WorkoutForFatBurn();
                      } else {
                        return Programs();
                      }
                    }));
                  });
                } on FirebaseAuthException catch (e) {
                  return e.message;
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            /*AlreadyHaveAnAccountCheck(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
