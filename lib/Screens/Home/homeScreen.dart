import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/Screens/Welcome/welcome_screen.dart';
import 'package:sport_app/Screens/userProfile/userProfile.dart';
import 'package:sport_app/frontLayer.dart';
import 'package:sport_app/playbook.dart';
import 'package:sport_app/programs.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  int currentIndex = 0;
  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Backdrop Example"),
        title: Center(
          //widthFactor uses for set the title at middle of appbar
          widthFactor: 2.5,
          child: Container(
            child: Text(
              " Sport APP ",
              style: TextStyle(color: Colors.white70),
            ),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        leading:
            new Container(), // this code for remove back button(arrow) from appbar
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                //sign out btn for now !!! change after debugging ....!!!
                onTap: () async {
                  await setState(() {
                    auth.signOut().then((value) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return WelcomeScreen();
                      }));
                    });
                  });
                },
                child: (Icon(Icons.power_settings_new_rounded))),
          )
        ],
      ),
      body: <Widget>[
        FrontLayer(), // main layer of app in first section ???
        Programs(),
        PlayBook(),
        UserProfile(),
      ][currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .1,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        //fabLocation: BubbleBottomBarFabLocation.end, //new // NOT NECCESSARY(this creates blank space on right side)
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        //inkColor: Colors.black, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey[800],
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home_rounded,
                color: Colors.blue,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey[800],
              icon: Icon(
                Icons.fitness_center_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.fitness_center_rounded,
                color: Colors.blue,
              ),
              title: Text("Programs")),
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey[800],
              icon: Icon(
                Icons.menu_book_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
              ),
              title: Text("Playbook")),
          BubbleBottomBarItem(
              backgroundColor: Colors.blueGrey[800],
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.account_circle_outlined,
                color: Colors.blue,
              ),
              title: Text("My Profile"))
        ],
      ),
    );
  }
}
