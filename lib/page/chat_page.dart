import 'package:flutter/material.dart';
import 'package:zanalytics/model/chat_message.dart';
import 'package:zanalytics/model/user_profile_data.dart';
import 'dart:async';

import 'package:zanalytics/page/quiz_taking_screen.dart';

class ChatPage extends StatefulWidget {
  final UserProfileData friendProfile;
  const ChatPage({super.key, required this.friendProfile});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController =
      TextEditingController();
  final ScrollController _scrollController =
      ScrollController();
  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;
    final message = ChatMessage.text(
      text: _textController.text.trim(),
      timestamp: DateTime.now(),
      isSentByMe: true,
    );

    setState(() {
      widget.friendProfile.addChatMessage(message);
      _textController.clear();
    });
    _scrollToBottom();
    _simulateFriendReply();
  }

  void _simulateFriendReply() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final reply = ChatMessage.text(
        text: "Интересная мысль! Надо будет проверить.",
        timestamp: DateTime.now(),
        isSentByMe: false,
      );

      setState(() {
        widget.friendProfile.addChatMessage(reply);
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendProfile.name),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: StreakFireIcon(streakCount: 1),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount:
                  widget.friendProfile.chatHistory.length,
              itemBuilder: (context, index) {
                final message =
                    widget.friendProfile.chatHistory[index];
                if (message.type == MessageType.quiz) {
                  return _QuizMessageBubble(
                    message: message,
                  );
                } else {
                  return _ChatMessageBubble(
                    message: message,
                  );
                }
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 2,
            color: Colors.black12,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                textCapitalization:
                    TextCapitalization.sentences,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Введите сообщение...',
                ),
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMyMessage = message.isSentByMe;
    return Align(
      alignment: isMyMessage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: isMyMessage
              ? Colors.amber[800]
              : Colors.grey[600],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.text ?? '', // Используем text
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _QuizMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _QuizMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final quiz = message.quiz!;
    final isMyMessage = message.isSentByMe;

    return Align(
      alignment: isMyMessage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMyMessage
              ? Colors.amber[900]
              : Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.quiz,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  "Приглашение на квиз",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white54),
            Text(
              quiz.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              quiz.description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizTakingScreen(quiz: quiz),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Начать"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Добавьте этот код в конец вашего файла lib/chat_page.dart
// ИЛИ создайте отдельный файл lib/widgets/streak_fire_icon.dart и импортируйте его.

class StreakFireIcon extends StatefulWidget {
  final int streakCount;

  const StreakFireIcon({
    super.key,
    required this.streakCount,
  });

  @override
  State<StreakFireIcon> createState() =>
      _StreakFireIconState();
}

// Используем SingleTickerProviderStateMixin для управления анимацией
class _StreakFireIconState extends State<StreakFireIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Создаем контроллер анимации
    _controller =
        AnimationController(
          duration: const Duration(milliseconds: 800),
          vsync: this,
        )..repeat(
          reverse: true,
        ); // Запускаем анимацию в бесконечном цикле (вперед-назад)

    // 2. Создаем саму анимацию на основе контроллера
    // Она будет плавно изменять значение от 1.0 до 1.2
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Обязательно освобождаем ресурсы
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Используем ScaleTransition для применения анимации масштабирования
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Иконка огня
          Icon(
            Icons.local_fire_department,
            color: Colors.orange.shade600,
            size: 30,
          ),
          // Текст с цифрой поверх иконки
          Text(
            widget.streakCount.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
