// lib/quiz_data.dart

import 'package:flutter/material.dart';
import 'package:zanalytics/model/quiz_models.dart'; // <-- Замените 'your_app' на имя вашего проекта

// Список всех доступных квизов
final List<Quiz> quizzes = [
  Quiz(
    title: "Основы сбережений",
    description:
        "Проверь, как хорошо ты знаешь базу финансовой грамотности.",
    icon: Icons.savings,
    questions: [
      QuizQuestion(
        questionText: 'Что такое "финансовая подушка"?',
        answers: [
          'Кредит на экстренный случай',
          'Деньги, отложенные на отпуск',
          'Денежный запас на 3-6 месяцев',
          'Вклад в банке под высокий процент',
        ],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        questionText:
            'Какой способ сбережений считается наименее рискованным?',
        answers: [
          'Акции',
          'Криптовалюта',
          'Банковский вклад',
          'Покупка недвижимости',
        ],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  Quiz(
    title: "Инвестиции для новичков",
    description:
        "Простые вопросы о том, как заставить деньги работать.",
    icon: Icons.trending_up,
    questions: [
      QuizQuestion(
        questionText:
            'Что такое "диверсификация" в инвестициях?',
        answers: [
          'Вложение всех денег в одну акцию',
          'Распределение вложений по разным активам',
          'Покупка акций на всю зарплату',
          'Игра на бирже без знаний',
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        questionText:
            'Что из этого НЕ является ценной бумагой?',
        answers: [
          'Акция',
          'Облигация',
          'Банковский депозит',
          'Паевой фонд',
        ],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        questionText: 'Что такое "брокерский счет"?',
        answers: [
          'Счет для оплаты коммуналки',
          'Счет для покупки и продажи ценных бумаг',
          'Личный счет брокера',
          'Счет для хранения криптовалюты',
        ],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  Quiz(
    title: "Борьба с долгами",
    description:
        "Знаешь ли ты, как правильно управлять кредитами?",
    icon: Icons.credit_card_off,
    questions: [
      QuizQuestion(
        questionText:
            'Какой долг стоит погасить в первую очередь?',
        answers: [
          'Самый большой по сумме',
          'Самый старый',
          'С самой высокой процентной ставкой',
          'Долг другу',
        ],
        correctAnswerIndex: 2,
      ),
    ],
  ),
];
