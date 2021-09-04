import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sport_app/Screens/Signup/userNameSelection.dart';
import 'package:sport_app/authentication_service.dart';
import 'package:sport_app/calculate/calculate.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var userID;
  _UserProfileState() {
    userID = firebaseUser.uid;
  }
  Future<String> getNameCurrentUser(var userID) async {
    setState(() {});
    /*
    return FirebaseFirestore.instance
        .collection('users/${userID}/userName')
        .get()
        .toString();*/

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['userName']);
    //print("username is :" + user['UserName']);
    // return user['userName'].toString();
  }

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

  Future<String> getBmiCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['BMI']);
  }

  Future<String> getBmrCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['BasalMetabolicRate']);
  }

  Future<String> getBodyFatCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['Body Fat']);
  }

  Future<String> getWaterNeedCurrentUser(var userID) async {
    setState(() {});

    return await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .get()
        .then((result) => result['waterNeed']);
  }

  @override
  void initState() {
    super.initState();
  }

  final kSpacingUnit = 10;

  @override
  Widget build(BuildContext context) {
    //getNameCurrentUser(userID);
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.only(top: 30),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.lightBlueAccent,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn4.vectorstock.com/i/thumb-large/27/28/avatar-lifting-weight-line-style-icon-vector-34442728.jpg"),
                      //backgroundImage: AssetImage('assets/images/main_top.png'),
                      radius: 46,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<String>(
              future: getNameCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: getMailCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: getRecommendedProgramCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      "Recommended Program : " + snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: getBmiCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("BMI : " + snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: getBmrCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("BMR : " + snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: getBodyFatCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("Body Fat(%) : " + snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: getWaterNeedCurrentUser(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("Water Need(.lt) : " + snapshot.data.toString());
                } else {
                  return Text("");
                }
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calculate()),
                );
              },
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.lightBlue,
                ),
                child: Center(
                  child: Text(
                    'Check-UP',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
