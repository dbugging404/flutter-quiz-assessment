// ignore_for_file: library_private_types_in_public_api, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> questions = [
    'What is the capital of France?',
    'What is 2 + 2?',
    'What is the capital of Japan?'
  ];

  final List<List<String>> options = [
    ['Paris', 'London', 'Berlin', 'Madrid'],
    ['3', '4', '5', '6'],
    ['Tokyo', 'Kyoto', 'Osaka', 'Nagoya']
  ];

  List<int?> answers = [null, null, null];
  int currentQuestion = 0;

  void _nextQuestion() {
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        Navigator.pushNamed(context, '/result', arguments: answers);
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (currentQuestion > 0) {
        currentQuestion--;
      }
    });
  }

  void _selectOption(int index) {
    setState(() {
      answers[currentQuestion] = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.pushNamed(context, '/result', arguments: answers);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[currentQuestion],
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ...options[currentQuestion].map((option) {
              int index = options[currentQuestion].indexOf(option);
              return RadioListTile<int>(
                title: Text(option),
                value: index,
                groupValue: answers[currentQuestion],
                onChanged: (int? index) => _selectOption(index!),
              );
            }).toList(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestion > 0)
                  ElevatedButton(
                    onPressed: _prevQuestion,
                    child: const Text('Previous'),
                  ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text(currentQuestion < questions.length - 1
                      ? 'Next'
                      : 'Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
