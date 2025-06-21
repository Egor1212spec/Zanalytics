import 'package:zanalytics/model/achivment.dart';
import 'package:zanalytics/model/chat_message.dart';

class UserProfileData {
  final String name;
  final List<Achievement> _achievements = [];

  UserProfileData(this.name);

  int get achievementsCount => _achievements.length;
  final List<ChatMessage> chatHistory = [];
  List<Achievement> get achievements =>
      List.unmodifiable(_achievements);

  Achievement getAchievement(int index) =>
      _achievements[index];

  void addAchievement(Achievement achievement) {
    if (!_achievements.any(
      (a) => a.name == achievement.name,
    )) {
      _achievements.add(achievement);
    }
  }

  void addAllAchievements(List<Achievement> achievements) {
    for (final achievement in achievements) {
      addAchievement(achievement);
    }
  }

  void clearAchievements() {
    _achievements.clear();
  }

  void addChatMessage(ChatMessage message) {
    // <-- Добавьте этот метод
    chatHistory.add(message);
  }
}
