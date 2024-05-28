import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'main.dart';
import 'workout/pushed_pageA.dart';
import 'workout/pushed_pageS.dart';
import 'workout/pushed_pageY.dart';

class MainScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MainScreen(this.cameras, {Key? key}) : super(key: key);

  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: const Text(
                'Exercises',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
            ),

            const SizedBox(height: 10),
            Image.asset('images/align.PNG'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: const SizedBox(
                // child: CustomSearchBar('What pose do you wish to align?'),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: const Text(
                'Strength',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              child: SizedBox(
                height: 150,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildExerciseButton('images/crunch.PNG', () {
                      print('hello');
                    }),
                    _buildExerciseButton('images/arm_press.PNG', () {
                      onSelectA(context: context, modelName: 'posenet');
                    }),
                    _buildExerciseButton('images/push_up.PNG', () {
                      print('hello');
                    }),
                    _buildExerciseButton('images/arm_press.PNG', () {
                      onSelectA(context: context, modelName: 'posenet');
                    }),
                    _buildExerciseButton('images/plank.PNG', () {
                      print('hello');
                    }),
                    _buildExerciseButton('images/lunge_squat.PNG', () {
                      print('hello');
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: const Text(
                'Yoga',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              child: SizedBox(
                height: 150,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildExerciseButton('images/yoga1.PNG', () {
                      print('hello');
                    }),
                    _buildExerciseButton('images/yoga4.PNG', () {
                      onSelectY(context: context, modelName: 'posenet');
                    }),
                    _buildExerciseButton('images/yoga2.PNG', () {
                      print('hello');
                    }),
                    _buildExerciseButton('images/yoga3.PNG', () {
                      print('hello');
                    }),
                    _buildExerciseButton('images/yoga5.PNG', () {
                      print('hello');
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseButton(String imagePath, VoidCallback onPressed) {
    return Stack(
      children: <Widget>[
        Container(
          width: 140,
          height: 140,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              primary: Colors.white,
            ),
            onPressed: onPressed,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(imagePath),
            ),
          ),
        ),
      ],
    );
  }

  void onSelectA({required BuildContext context, required String modelName}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PushedPageA(
          cameras: cameras,
          title: modelName,
        ),
      ),
    );
  }

  void onSelectS({required BuildContext context, required String modelName}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PushedPageS(
          cameras: cameras,
          title: modelName,
        ),
      ),
    );
  }

  void onSelectY({required BuildContext context, required String modelName}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PushedPageY(
          cameras: cameras,
          title: modelName,
        ),
      ),
    );
  }
}
