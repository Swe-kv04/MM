import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<Question> _questions = [
    Question("What is the capital of France?",
        ["Paris", "London", "Berlin", "Rome"], 0),
    Question("Which planet is known as the Red Planet?",
        ["Earth", "Mars", "Jupiter", "Saturn"], 1),
    Question("What is 5 + 3?", ["5", "8", "10", "15"], 1),
  ];

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Quiz Completed!"),
        content: Text("Your Score: $_score / ${_questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
              });
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _questions[_currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ..._questions[_currentQuestionIndex].answers.asMap().entries.map(
                  (entry) => ElevatedButton(
                    onPressed: () => _answerQuestion(entry.key),
                    child: Text(entry.value),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.questionText, this.answers, this.correctAnswerIndex);
}
