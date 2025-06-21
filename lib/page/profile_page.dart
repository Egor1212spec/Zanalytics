// final List<Achievement> achievements = const [
//   Achievement(
//     name: "Первый шаг",
//     description: "Успешно зарегестрироваться.",
//     iconData: Icons.flag_circle,
//   ),
//   Achievement(
//     name: "Коллекционер",
//     description: "Собрать 10 редких предметов.",
//     iconData: Icons.inventory_2,
//   ),
//   Achievement(
//     name: "Исследователь",
//     description: "Посетить 5 разных локаций.",
//     iconData: Icons.explore,
//   ),
//   Achievement(
//     name: "Непобедимый",
//     description: "Пройти уровень без получения урона.",
//     iconData: Icons.shield,
//   ),
//   Achievement(
//     name: "Мастер на все руки",
//     description: "Создать 50 уникальных предметов.",
//     iconData: Icons.construction,
//   ),
//   Achievement(
//     name: "Богач",
//     description: "Накопить 10,000 золота.",
//     iconData: Icons.monetization_on,
//   ),
// ];

import 'package:flutter/material.dart';
import 'package:zanalytics/model/achivment.dart';
import 'package:zanalytics/model/user_profile_data.dart';
import 'package:zanalytics/page/chat_page.dart';

class ProfilePage extends StatefulWidget {
  final UserProfileData userProfile;

  const ProfilePage({required this.userProfile, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final List<Achievement> achievements =
      widget.userProfile.achievements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.userProfile.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ), // <-- Добавим отступ
                // --- НОВАЯ КНОПКА ДЛЯ ПЕРЕХОДА В ЧАТ ---
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          friendProfile: widget.userProfile,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                  ),
                  label: const Text('Написать сообщение'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
                // ------------------------------------
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Достижения',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
          Expanded(
            child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Icon(
                      achievement.iconData,
                      color: Colors.amber,
                      size: 40,
                    ),
                    title: Text(
                      achievement.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(achievement.description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
