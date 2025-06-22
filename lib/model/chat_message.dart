import 'package:zanalytics/model/quiz_models.dart';

enum MessageType { text, quiz }

class ChatMessage {
  final String? text;
  final Quiz? quiz;
  final MessageType type;

  final DateTime timestamp;
  final bool isSentByMe;
  ChatMessage.text({
    required this.text,
    required this.timestamp,
    required this.isSentByMe,
  }) : type = MessageType.text,
       quiz = null;

  ChatMessage.quiz({
    required this.quiz,
    required this.timestamp,
    required this.isSentByMe,
  }) : type = MessageType.quiz,
       text = null;
}
