import 'package:flutter/material.dart';
import 'package:zanalytics/model/achivment.dart';
import 'package:zanalytics/model/chat_message.dart';
import 'package:zanalytics/model/user_profile_data.dart';

class MockDataRepository {
  static final List<UserProfileData> _friendsCache =
      _generateMockFriends();
  List<UserProfileData> getFriends() {
    return _friendsCache;
  }

  static List<UserProfileData> _generateMockFriends() {
    var anna = UserProfileData("Анна");
    anna.addAchievement(
      const Achievement(
        name: "Королева аналитики",
        description: "Провела в приложении 100 часов",
        iconData: Icons.shield_moon,
      ),
    );
    anna.addChatMessage(
      ChatMessage.text(
        text: "Привет! Как успехи с инвестициями?",
        timestamp: DateTime.now().subtract(
          const Duration(minutes: 10),
        ),
        isSentByMe: false,
      ),
    );
    anna.addChatMessage(
      ChatMessage.text(
        text: "Привет! Все отлично, изучаю новые графики.",
        timestamp: DateTime.now().subtract(
          const Duration(minutes: 9),
        ),
        isSentByMe: true,
      ),
    );

    var petr = UserProfileData("Петр");
    petr.addAchievement(
      const Achievement(
        name: "Новичок",
        description: "Первый вход в приложение",
        iconData: Icons.star_border,
      ),
    );
    petr.addChatMessage(
      ChatMessage.text(
        text: "Го на квиз сегодня вечером?",
        timestamp: DateTime.now().subtract(
          const Duration(hours: 2),
        ),
        isSentByMe: true,
      ),
    );

    var olga = UserProfileData("Ольга");
    olga.addAchievement(
      const Achievement(
        name: "Инвестор",
        description: "Совершила первую сделку",
        iconData: Icons.show_chart,
      ),
    );

    return [anna, petr, olga];
  }
}
