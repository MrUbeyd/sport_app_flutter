import 'package:flutter/material.dart';
import 'package:sport_app/Screens/Signup/choseUsernameScreen.dart';

class UserNameSelection extends StatelessWidget {
  final String userID;
  UserNameSelection({Key key, @required this.userID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseUsername(
        userID: userID,
      ),
    );
  }
}
