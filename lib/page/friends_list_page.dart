import 'package:flutter/material.dart';
import 'package:zanalytics/data/mock_data_repository.dart';

import 'package:zanalytics/model/user_profile_data.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() =>
      _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  late final List<UserProfileData> _friends;

  @override
  void initState() {
    super.initState();
    _friends = MockDataRepository().getFriends();
  }

  int _selectedIndex = 3;
  void _navigateToProfile(UserProfileData friend) {
    Navigator.pushNamed(
      context,
      '/profile',
      arguments: friend,
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
    if (index == 2) {
      Navigator.popAndPushNamed(context, '/quiz');
    }
    if (index == 1) {
      Navigator.popAndPushNamed(context, '/tiktok');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Друзья'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _friends.length,
        itemBuilder: (context, index) {
          final friend = _friends[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(
                  friend.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                friend.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'Достижений: ${friend.achievements.length}',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => _navigateToProfile(friend),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(
          255,
          33,
          31,
          31,
        ),
        unselectedItemColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tiktok),
            label: 'Аналитика',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'квиз',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Друзья',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
