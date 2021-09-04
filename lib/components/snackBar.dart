import 'package:flutter/material.dart';

class MySnackBars {
  showSnackBarBool(bool isOkey) {
    if (isOkey) {
      return SnackBar(
        content: Text(
          "UserName is available :) ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[800],
      );
    } else {
      return SnackBar(
        content: Text(
          "UserName is taken, please try again... ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
      );
    }
  }

  showSnackBarPasswordError() {
    return SnackBar(
      content: Text(
        "Passwords must be same ",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red[800],
    );
  }

  showSnackBarUserNameError() {
    return SnackBar(
      content: Text(
        "Please enter unused UserName",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red[800],
    );
  }

  showSnackBarUserNameNullError() {
    return SnackBar(
      content: Text(
        "UserName can't be null !!!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red[900],
    );
  }
}
