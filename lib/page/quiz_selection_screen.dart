import 'package:flutter/material.dart';

import 'package:zanalytics/data/quiz_data.dart';
import 'package:zanalytics/model/quiz_models.dart';
import 'package:zanalytics/page/quiz_taking_screen.dart';
import 'package:zanalytics/page/share_with_friend_screen.dart';

class QuizSelectionScreen extends StatefulWidget {
  const QuizSelectionScreen({Key? key}) : super(key: key);

  @override
  State<QuizSelectionScreen> createState() =>
      _QuizSelectionScreenState();
}

class _QuizSelectionScreenState
    extends State<QuizSelectionScreen> {
  int _selectedIndex = 2;

  void _selectQuiz(BuildContext context, Quiz quiz) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizTakingScreen(quiz: quiz),
      ),
    );
  }

  void _shareQuizInApp(Quiz quiz) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShareWithFriendScreen(quizToShare: quiz),
      ),
    );
  }

  void _onItemTapped(int index) {
    // Обновляем состояние, чтобы BottomNavigationBar перерисовался
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Предполагаем, что есть главный экран, на который можно вернуться
      // Если это корневой экран для этой вкладки, то можно ничего не делать или использовать Navigator.popUntil
      Navigator.popAndPushNamed(context, '/');
    }
    if (index == 1) {
      Navigator.popAndPushNamed(context, '/tiktok');
    }
    if (index == 3) {
      Navigator.popAndPushNamed(context, '/friends');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Выберите квиз'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: Icon(
                quiz.icon,
                size: 40,
                color: Colors.amber[800],
              ),
              title: Text(
                quiz.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(quiz.description),
              onTap: () => _selectQuiz(context, quiz),
              trailing: IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareQuizInApp(quiz),
                tooltip: 'Поделиться квизом',
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tiktok),
            label: 'Аналитика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Квиз',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Друзья',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap:
            _onItemTapped, // Передаем метод без аргументов
      ),
    );
  }
}
