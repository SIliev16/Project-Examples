import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesScreen extends StatefulWidget {
  @override
  _UserPreferencesScreenState createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  int _currentQuestionIndex = 0;

  final List<String> _questions = [
    'Which of these genres do you frequently listen to?',
    'Do you have a favorite decade for music?',
    'How do you feel about instrumentals or tracks without lyrics?',
    'Do you enjoy discovering international music or songs in languages other than English?',
    'How often do you drive?',
    'How do you prefer your music during the morning drives?',
    'What type of drives do you usually take?',
  ];

  final List<List<String>> _answerOptions = [
    ['Rock', 'Jazz', 'Pop', 'Classical', 'EDM', 'Hip-Hop', 'Country', 'World Music'],
    ['60s', '70s', '80s', '90s', '2000s', '2010s', '2020s'],
    ['Love them', 'Prefer songs with lyrics', 'Neutral'],
    ['Always', 'Occasionally', 'Rarely', 'Never'],
    ['Daily', 'Few times a week', 'Weekends only', 'Occasionally'],
    ['Energetic & Uplifting', 'Calm & Soothing', 'Whatever\'s trending', 'No preference'],
    ['Commute', 'Long scenic drives', 'Quick errands', 'Off-road adventures'],
  ];

  final List<int> _multipleAnswerIndexes = [0, 1, 5];

  final Map<String, List<String>> _selectedMultipleAnswers = {};
  final Map<String, String> _selectedSingleAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tailoring the app to your experience..',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildProgressBar(),
            const SizedBox(height: 40),
            Text(
              _questions[_currentQuestionIndex],
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            if (_multipleAnswerIndexes.contains(_currentQuestionIndex))
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Multiple answers possible', textAlign: TextAlign.center),
              ),
            const SizedBox(height: 40),
            Expanded(child: _buildAnswerOptions()),
            _buildNavigationButtons()
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    double progress = (_currentQuestionIndex + 1) / _questions.length;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        height: 10,
        child: LinearProgressIndicator(
          value: progress,
          color: Colors.orange,
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: _answerOptions[_currentQuestionIndex].map((answer) {
        bool isSelected = _multipleAnswerIndexes.contains(_currentQuestionIndex)
            ? (_selectedMultipleAnswers[_questions[_currentQuestionIndex]]?.contains(answer) ?? false)
            : _selectedSingleAnswers[_questions[_currentQuestionIndex]] == answer;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: isSelected ? const Color(0xFFFFC100) : const Color(0xFFFEFFF6), // text color
            textStyle: const TextStyle(fontSize: 16),
            side: BorderSide(color: const Color(0xFFFFC100), width: isSelected ? 0 : 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () => _selectAnswer(answer),
          child: Text(answer),
        );
      }).toList(),
    );
  }


  Widget _buildNavigationButtons() {
    return Column(
      children: [
        if (_isComplete)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: const Color(0xFFFFC100),
                textStyle: const TextStyle(fontSize: 16)
            ),
            onPressed: _completeQuestionnaire,
            child: const Text("Complete questionnaire"),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _currentQuestionIndex > 0
                  ? () {
                setState(() {
                  _currentQuestionIndex--;
                });
              }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _currentQuestionIndex < _questions.length - 1
                  ? () {
                setState(() {
                  _currentQuestionIndex++;
                });
              }
                  : null,
            ),
          ],
        )
      ],
    );
  }


  void _selectAnswer(String answer) {
    setState(() {
      if (_multipleAnswerIndexes.contains(_currentQuestionIndex)) {
        if (_selectedMultipleAnswers[_questions[_currentQuestionIndex]]?.contains(answer) ?? false) {
          _selectedMultipleAnswers[_questions[_currentQuestionIndex]]?.remove(answer);
        } else {
          _selectedMultipleAnswers[_questions[_currentQuestionIndex]] = (_selectedMultipleAnswers[_questions[_currentQuestionIndex]] ?? [])..add(answer);
        }
      } else {
        _selectedSingleAnswers[_questions[_currentQuestionIndex]] = answer;
      }
    });

    if (_currentQuestionIndex == _questions.length) {
      _completeQuestionnaire();
    }

    _checkCompletion();
  }

  bool _isComplete = false;

  void _checkCompletion() {
    for (var i = 0; i < _questions.length; i++) {
      if (_multipleAnswerIndexes.contains(i)) {
        if ((_selectedMultipleAnswers[_questions[i]]?.isEmpty ?? true)) {
          setState(() {
            _isComplete = false;
          });
          return;
        }
      } else {
        if (_selectedSingleAnswers[_questions[i]] == null) {
          setState(() {
            _isComplete = false;
          });
          return;
        }
      }
    }
    setState(() {
      _isComplete = true;
    });
  }


  Future<void> _completeQuestionnaire() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userSinglePreferences', _selectedSingleAnswers.toString());
    prefs.setString('userMultiplePreferences', _selectedMultipleAnswers.toString());
    prefs.setBool('hasCompletedQuestionnaire', true);
    Navigator.pushReplacementNamed(context, '/dashboard');
    print("Single Answers: $_selectedSingleAnswers");
    print("Multiple Answers: $_selectedMultipleAnswers");
  }
}
