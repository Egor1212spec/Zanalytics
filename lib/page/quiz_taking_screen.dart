import 'package:flutter/material.dart';
import 'package:zanalytics/model/quiz_models.dart';

class QuizTakingScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizTakingScreen({Key? key, required this.quiz})
    : super(key: key);

  @override
  _QuizTakingScreenState createState() =>
      _QuizTakingScreenState();
}

class _QuizTakingScreenState
    extends State<QuizTakingScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  void _answerQuestion(int selectedIndex) {
    if (_selectedAnswerIndex != null) return;

    setState(() {
      _selectedAnswerIndex = selectedIndex;
      if (selectedIndex ==
          widget
              .quiz
              .questions[_currentQuestionIndex]
              .correctAnswerIndex) {
        _score++;
      }
    });

    Future.delayed(
      const Duration(milliseconds: 1500),
      _nextQuestion,
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex <
        widget.quiz.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
      });
    } else {
      _showResultsDialog();
    }
  }

  void _restartQuiz() {
    Navigator.of(context).pop();
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswerIndex = null;
    });
  }

  void _showResultsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Квиз завершен!'),
          content: Text(
            'Ваш результат: $_score из ${widget.quiz.questions.length}',
            style: const TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Пройти заново'),
              onPressed: _restartQuiz,
            ),
            TextButton(
              child: const Text('К списку квизов'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color _getButtonColor(int index) {
    if (_selectedAnswerIndex == null) {
      return Colors.orange;
    }

    final correctIndex = widget
        .quiz
        .questions[_currentQuestionIndex]
        .correctAnswerIndex;
    if (index == correctIndex) {
      return Colors.green;
    } else if (index != correctIndex) {
      return Colors.red;
    }

    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion =
        widget.quiz.questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(title: Text(widget.quiz.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              currentQuestion.questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            ...List.generate(
              currentQuestion.answers.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: ElevatedButton(
                    onPressed: _selectedAnswerIndex == null
                        ? () => _answerQuestion(index)
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,

                      backgroundColor: _getButtonColor(
                        index,
                      ),
                      disabledBackgroundColor:
                          _getButtonColor(index),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      currentQuestion.answers[index],
                    ),
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
