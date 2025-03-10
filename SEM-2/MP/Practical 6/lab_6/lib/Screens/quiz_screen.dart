import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the number after 2?',
      'options': ['1', '2', '3', '4'],
      'answer': '3'
    },
    {
      'question': 'Which letter comes after A?',
      'options': ['C', 'B', 'D', 'E'],
      'answer': 'B'
    },
    {
      'question': 'How many legs does a cat have?',
      'options': ['2', '3', '4', '5'],
      'answer': '4'
    },
    {
      'question': 'What color is the sky?',
      'options': ['Green', 'Blue', 'Red', 'Yellow'],
      'answer': 'Blue'
    },
    {
      'question': 'Which fruit is yellow and curved?',
      'options': ['Apple', 'Banana', 'Grapes', 'Strawberry'],
      'answer': 'Banana'
    }
  ];

  void _checkAnswer(String selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }
    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completed!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/success.json', width: 200, height: 200),
            SizedBox(height: 10),
            Text("Your Score: $_score / ${_questions.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
              });
              Navigator.pop(context);
            },
            child: Text("Play Again"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _questions[_currentQuestionIndex]['question'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _questions[_currentQuestionIndex]['options'].length,
              itemBuilder: (context, index) {
                String option = _questions[_currentQuestionIndex]['options'][index];
                return ElevatedButton(
                  onPressed: () => _checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}