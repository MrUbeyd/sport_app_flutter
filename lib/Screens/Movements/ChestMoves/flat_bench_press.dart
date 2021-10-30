import 'package:flutter/material.dart';

class FlatBenchPress extends StatelessWidget {
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
                  "assets/images/movements/chest/flat-bench-press.gif",
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
                    "Flat Bench Press",
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
                    '''Lie down on the flat bench so that your neck and head are supported. Your knees should be at a 90-degree angle with your feet flat on the floor. If your back comes off the bench, you might consider putting your feet on the bench instead of the floor. Position yourself underneath the bar so that the bar is in line with your chest. Place your hands slightly wider than your shoulders, with your elbows flexed at a 90-degree angle. Grasp the bar, palms facing away from you, with your fingers wrapped around it.
Exhale, squeeze your core, and push the barbell off the rack and up toward the ceiling using your pectoral muscles. Straighten your arms out in the contracted position, and squeeze your chest.
Inhale and bring the barbell down slowly to your chest, again about an inch away. It should take you twice as long to bring the barbell down as it does to push it up.
Explode back up to your starting position using your pectoral muscles. Do 12 repetitions and then add more weight for your next set.''',
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
