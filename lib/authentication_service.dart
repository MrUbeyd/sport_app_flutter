import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> updateUserData(
      String email, String nameSurname, var userID) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users
        .doc(userID)
        .set({
          "email": email,
          "nameSurname": nameSurname,
          "userName": "-",
          "recommendedProgram": "-",
          "waterNeed": "-",
          "BMI": "-",
          "Body Fat": "-",
          "BasalMetabolicRate": "-"
        })
        .then((value) => print("User Added , userID is:" + userID))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUserBodyData(
      String email,
      String nameSurname,
      String userName,
      String recommendedProgram,
      String waterNeed,
      String bmi,
      String bodyFat,
      String bmr,
      var userID) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users
        .doc(userID)
        .set({
          "email": email,
          "nameSurname": nameSurname,
          "userName": userName,
          "recommendedProgram": recommendedProgram,
          "waterNeed": waterNeed,
          "BMI": bmi,
          "Body Fat": bodyFat,
          "BasalMetabolicRate": bmr
        })
        .then((value) => print("User Checked Up , userID is:" + userID))
        .catchError((error) => print("Failed to Check Up user: $error"));
  }

  Future<void> addUserName(String userName, var userID) async {
    //this must update the storage with
    //email,nameSurname,messageCount,likes,degree,isPremium
    //userName must select after and add this data
    CollectionReference userNames =
        FirebaseFirestore.instance.collection('userNames');
    return await userNames
        .doc(userName)
        .set({"userID": userID})
        .then((value) => print("UserName Added with userID: " + userID))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> checkUserNameAvailable(String userName) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("userNames")
        .doc(userName)
        .get();
    //.then((doc) {
    if (snapShot.exists) {
      print("username takennnnnnnnnnnnnnnnnnnnnn");
      return false;
      //return "Username is taken, please try another username ... ";

    } else {
      print("username availableeeeeeeeeeeeeeeeeeee");
      return true;
      //return "Username is available :)";
    }
    //}
    //)
  }

  getNameSurname(var userID) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(result.id)
            .collection("userName")
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            print(result.data());
          });
        });
      });
    });
  }

  Future<String> getUserNameSurname(var userID) async {
    String nameSurname;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .collection("/nameSurname")
          .get()
          .then((value) {
        nameSurname = value.toString();
      });
      return nameSurname;
    } catch (e) {
      print(e);
    }
  }
}
