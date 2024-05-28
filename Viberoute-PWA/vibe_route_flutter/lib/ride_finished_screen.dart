import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class RideFinishedScreen extends StatefulWidget {
  const RideFinishedScreen({Key? key}) : super(key: key);

  @override
  _RideFinishedScreenState createState() => _RideFinishedScreenState();
}

class _RideFinishedScreenState extends State<RideFinishedScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showFeedbackMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFFF6),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Ride Finished!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: const [
                        Text(
                          'Your statistics for this ride',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Drove 16.4 km equivalent to driving across your house and work 4 times!',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'You drove for 45 minutes, roughly 12 songs!',
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Average speed was: 75 km/h',
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your mood shifted from energetic to calm. We played more relaxing tracks in the second half of your ride!',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'How was your music experience?',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _showFeedbackMessage('I am sorry that your ride did not go well.'),
                      child: const Text('😠', style: TextStyle(fontSize: 24)),
                    ),
                    GestureDetector(
                      onTap: () => _showFeedbackMessage('Thanks for your feedback!'),
                      child: const Text('😐', style: TextStyle(fontSize: 24)),
                    ),
                    GestureDetector(
                      onTap: () => _showFeedbackMessage('Great to hear you enjoyed your ride!'),
                      child: const Text('😊', style: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    // Assuming your dashboard screen is named '/dashboard' in your named route configuration.
                    Navigator.of(context).pushReplacementNamed('/dashboard'); // This will close the RideFinishedScreen and open the Dashboard.
                  },
                  child: const Text('Done'),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}