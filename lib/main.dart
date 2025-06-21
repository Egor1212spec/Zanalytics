import 'package:flutter/material.dart';
import 'package:zanalytics/model/achivment.dart';
import 'package:zanalytics/model/user_profile_data.dart';
import 'package:zanalytics/page/fin_story_screen.dart';
import 'package:zanalytics/page/friends_list_page.dart';
import 'package:zanalytics/page/home_page.dart';
import 'package:zanalytics/page/profile_page.dart';
import 'package:zanalytics/page/quiz_selection_screen.dart';

void main() {
  UserProfileData user = UserProfileData("Егор");
  const Achievement firstAchievement = Achievement(
    name: "Первый шаг",
    description: "Успешная регистрация",
    iconData: Icons.wb_sunny,
  );
  user.addAchievement(firstAchievement);
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final UserProfileData user;

  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zanalytics',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(user: user),
      routes: {
        '/profile': (context) {
          final user =
              ModalRoute.of(context)!.settings.arguments
                  as UserProfileData;
          return ProfilePage(userProfile: user);
        },
        '/home': (context) {
          final user =
              ModalRoute.of(context)!.settings.arguments
                  as UserProfileData;
          return HomePage(user: user);
        },
        '/tiktok': (context) => const FinStoryScreen(),
        '/friends': (context) => const FriendsListPage(),
        '/quiz': (context) => const QuizSelectionScreen(),
      },
    );
  }
}
