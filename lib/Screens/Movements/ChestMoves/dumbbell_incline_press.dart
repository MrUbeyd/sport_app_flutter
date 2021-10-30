import 'package:flutter/material.dart';

class DumbbellInclinePress extends StatelessWidget {
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
                  "assets/images/movements/chest/dumbbell-incline-press.gif",
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
                    "Dumbbell Incline Press",
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
                    '''Adjust the bench to an incline of 15–30 degrees.
Sit on the bench and place two dumbbells in the creases of your hips.
Lie back on the bench with the dumbbells, and, once in position, engage your core.
Press the dumbbells toward the ceiling. Your palms should be facing forward. Rotate your shoulders outward to engage your lats. Your upper back should remain tight and stable throughout the entire set. All repetitions should begin from this position.
Slowly lower the dumbbell until your upper arm is slightly past your back. Your elbows should be at a 45-degree angle to your torso, while maintaining a neutral wrist.
Pause for a second at the bottom of the rep.
To begin the upward movement, squeeze your chest and push the dumbbells back toward the starting position.
Continue to press until your arms are long with a slight bend in your elbows. Finish the movement at the top by squeezing your chest.
Maintain distance between the dumbbells at the end of the repetition.''',
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
