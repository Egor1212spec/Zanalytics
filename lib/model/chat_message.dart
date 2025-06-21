// lib/model/chat_message.dart

import 'package:zanalytics/model/quiz_models.dart'; // <-- Добавьте импорт квиза

// 1. Enum для определения типа сообщения
enum MessageType { text, quiz }

class ChatMessage {
  final String? text; // Текст теперь опционален
  final Quiz? quiz; // Поле для квиза тоже опционально
  final MessageType type; // Тип сообщения обязателен

  final DateTime timestamp;
  final bool isSentByMe;

  // 2. Создаем два конструктора для удобства

  // Конструктор для текстовых сообщений
  ChatMessage.text({
    required this.text,
    required this.timestamp,
    required this.isSentByMe,
  }) : type = MessageType.text,
       quiz = null;

  // Конструктор для сообщений с квизом
  ChatMessage.quiz({
    required this.quiz,
    required this.timestamp,
    required this.isSentByMe,
  }) : type = MessageType.quiz,
       text = null;
}
