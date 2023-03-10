import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<String> questions = [
    "The capital of France is ___.",
    "The tallest mammal in the world is the ___.",
    "The largest country in the world by land area is ___."
  ];

  int currentIndex = 0;
  TextEditingController textController = TextEditingController();
  List<String> userAnswers = [];

  void submitAnswer() {
    setState(() {
      userAnswers.add(textController.text);
      textController.clear();
      currentIndex = (currentIndex + 1) % questions.length;
      if (currentIndex == 0) {
        _showResults();
      }
    });
  }

  void _showResults() {
    List<Widget> results = [];
    for (int i = 0; i < questions.length; i++) {
      results.add(ListTile(
        title: Text(questions[i]),
        subtitle: Text("Your answer: ${userAnswers[i]}"),
      ));
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Quiz Results"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: results,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                userAnswers.clear();
              });
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentIndex],
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Your answer",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: submitAnswer,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
