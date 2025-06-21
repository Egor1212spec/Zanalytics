// lib/share_with_friend_screen.dart

import 'package:flutter/material.dart';
import 'package:zanalytics/data/mock_data_repository.dart';
import 'package:zanalytics/model/quiz_models.dart';
import 'package:zanalytics/model/user_profile_data.dart';
import 'package:zanalytics/model/chat_message.dart';

class ShareWithFriendScreen extends StatefulWidget {
  final Quiz quizToShare;

  const ShareWithFriendScreen({
    super.key,
    required this.quizToShare,
  });

  @override
  State<ShareWithFriendScreen> createState() =>
      _ShareWithFriendScreenState();
}

class _ShareWithFriendScreenState
    extends State<ShareWithFriendScreen> {
  // В реальном приложении этот список должен приходить из state-менеджера,
  // а не генерироваться заново. Для примера - это приемлемо.
  final List<UserProfileData> _friends =
      MockDataRepository().getFriends();

  void _sendQuizToFriend(UserProfileData friend) {
    // Создаем сообщение типа "квиз"
    final quizMessage = ChatMessage.quiz(
      quiz: widget.quizToShare,
      timestamp: DateTime.now(),
      isSentByMe: true,
    );

    // Добавляем сообщение в историю чата друга
    setState(() {
      friend.addChatMessage(quizMessage);
    });

    // Показываем подтверждение и закрываем экран
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Квиз "${widget.quizToShare.title}" отправлен пользователю ${friend.name}!',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поделиться с другом'),
      ),
      body: ListView.builder(
        itemCount: _friends.length,
        itemBuilder: (context, index) {
          final friend = _friends[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(friend.name[0]),
            ),
            title: Text(friend.name),
            onTap: () => _sendQuizToFriend(friend),
          );
        },
      ),
    );
  }
}
