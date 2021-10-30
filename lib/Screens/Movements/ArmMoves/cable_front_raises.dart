import 'package:flutter/material.dart';

class CableFrontRaises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
              onPressed: () => Navigator.of(context).pop(),
            ),
            snap: true,
            floating: true,
            backgroundColor: const Color(0xFFE9E9E9),
            expandedHeight: 300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
                child: Image.asset(
                  "assets/images/movements/arm/cable-front-raises.gif",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    "Cable Front Raises",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Explanation",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                  child: Text(
                    '''Step 1: Choose a weight on the low pulley machine and grab the single hand cable attachment with your left hand.
Step 2: Turn away from the pulley and hold your arm straight down so that the hand cable attachment is in front of your thigh. The palm of your hand should be facing down. This is the starting position.
Step 3: Lift your left arm to the front. Bend your elbow slightly and keep the palm of your hand facing down. Continue lifting until your arm is positioned slightly above the level where it would be parallel to the floor. Exhale as you do so and hold the position for a second when you reach the top.
Step 4: As you inhale, lower your arm slowly to the starting position.
Step 5: Repeat for the number of reps in your set and then switch to the right arm.''',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
