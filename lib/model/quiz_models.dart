// lib/quiz_models.dart

import 'package:flutter/material.dart';

// Модель для одного вопроса
class QuizQuestion {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  const QuizQuestion({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

// Модель для целого квиза
class Quiz {
  final String title;
  final String description;
  final IconData icon;
  final List<QuizQuestion> questions;

  const Quiz({
    required this.title,
    required this.description,
    required this.icon,
    required this.questions,
  });
}
