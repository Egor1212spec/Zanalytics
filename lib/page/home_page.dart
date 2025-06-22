import 'package:flutter/material.dart';
import 'package:zanalytics/model/user_profile_data.dart';
import 'package:zanalytics/page/profile_page.dart';

class HomePage extends StatefulWidget {
  final UserProfileData user;

  const HomePage({Key? key, required this.user})
    : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/tiktok');
    }
    if (index == 2) {
      Navigator.pushNamed(context, '/quiz');
    }
    if (index == 3) {
      Navigator.pushNamed(
        context,
        '/friends',
        // arguments: widget.user,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  hintText: "Поиск...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(
          255,
          33,
          31,
          31,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              ProfileIcon(widget.user),
              SizedBox(height: 8),

              SizedBox(height: 20),
              user_card_optim(),
              SizedBox(height: 20),
              GoalProgressCard(
                currentAmount: 12750,
                goalAmount: 15000,
                goalImageAssetPath:
                    'assets/images/crossfon.png',
              ),
              SizedBox(height: 20),
              const AchievementsSection(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  operation(),
                  SizedBox(width: 20),
                  bonus(),
                ],
              ),
              SizedBox(height: 20),
              user_card(),
            ],
          ),
        ),
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

class user_card_optim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: ColoredBox(
        color: const Color.fromARGB(255, 33, 31, 31),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Если уменшить траты на фастфуд то можно сэкономить 500 рублей \u{1F600}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  final UserProfileData _user;
  ProfileIcon(this._user);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProfilePage(userProfile: _user),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Text(
              "E",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            "Егор",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class operation extends StatefulWidget {
  const operation({super.key});

  @override
  State<operation> createState() => _operationState();
}

class _operationState extends State<operation> {
  final List<ProgressSegment> spendingSegments = [
    ProgressSegment(color: Colors.blue, value: 0.40),
    ProgressSegment(color: Colors.green, value: 0.25),
    ProgressSegment(color: Colors.orange, value: 0.15),
    ProgressSegment(color: Colors.yellow, value: 0.2),
  ];
  @override
  Widget build(BuildContext context) {
    String x = "1 679";
    return Expanded(
      flex: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: ColoredBox(
          color: const Color.fromARGB(255, 33, 31, 31),
          child: Padding(
            padding: const EdgeInsets.all(12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    "Все операции",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Трат в июне ${x} ₽",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 16),
                SegmentedProgressIndicator(
                  segments: spendingSegments,
                  height: 25,
                  borderRadius: BorderRadius.circular(12),
                  backgroundColor: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class bonus extends StatefulWidget {
  const bonus({super.key});

  @override
  State<bonus> createState() => _bonusState();
}

class _bonusState extends State<bonus> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: ColoredBox(
          color: const Color.fromARGB(255, 33, 31, 31),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    "Кэшбек",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "и бонусы",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(
                        'assets/icons/KB.png',
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Image.asset(
                          'assets/icons/5.png',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Image.asset(
                          'assets/icons/golden_apple.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressSegment {
  final Color color;
  final double value;

  ProgressSegment({
    required this.color,
    required this.value,
  });
}

class SegmentedProgressIndicator extends StatelessWidget {
  final List<ProgressSegment> segments;
  final double height;
  final BorderRadius borderRadius;
  final Color backgroundColor;

  const SegmentedProgressIndicator({
    Key? key,
    required this.segments,
    this.height = 20,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(30),
    ),
    this.backgroundColor = const Color.fromARGB(
      255,
      224,
      224,
      224,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        child: Stack(
          children: [
            Container(color: backgroundColor),
            Row(
              children: segments.map((segment) {
                return Expanded(
                  flex: (segment.value * 1000).toInt(),
                  child: Container(color: segment.color),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class user_card extends StatefulWidget {
  const user_card({super.key});

  @override
  State<user_card> createState() => _user_cardState();
}

class _user_cardState extends State<user_card> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: ColoredBox(
          color: const Color.fromARGB(255, 33, 31, 31),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.currency_ruble,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      "1 876,323 ₽",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "ALL Games",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,

                  child: Icon(Icons.credit_card),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoalProgressCard extends StatelessWidget {
  final double currentAmount;
  final double goalAmount;
  final String? goalImageAssetPath;

  const GoalProgressCard({
    Key? key,
    required this.currentAmount,
    required this.goalAmount,
    this.goalImageAssetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = (currentAmount / goalAmount)
        .clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: ColoredBox(
        color: const Color.fromARGB(255, 33, 31, 31),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.savings_outlined,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Копить до цели",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        backgroundColor: Colors.grey[800],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(
                              Colors.blueAccent,
                            ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${currentAmount.toStringAsFixed(0)} ₽',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${goalAmount.toStringAsFixed(0)} ₽',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (goalImageAssetPath != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    child: Image.asset(
                      goalImageAssetPath!,
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Отслеживаемые ачивки",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AchievementCard(
              icon: Icons.savings,
              title: "Копилка-герой",
              progressText: "12750/15000 ₽",
              progressValue: 12750 / 15000,
              color: Colors.blueAccent,
            ),
            AchievementCard(
              icon: Icons.star_rounded,
              title: "Гуру кэшбэка",
              progressText: "241/500 ₽",
              progressValue: 241 / 500,
              color: Colors.amber[800]!,
            ),
            AchievementCard(
              icon: Icons.directions_walk,
              title: "Челлендж недели",
              progressText: "3/5 дней",
              progressValue: 3 / 5,
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}

class AchievementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String progressText;
  final double progressValue;
  final Color color;

  const AchievementCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.progressText,
    required this.progressValue,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 135,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: ColoredBox(
          color: const Color.fromARGB(255, 33, 31, 31),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: progressValue,
                        strokeWidth: 5,
                        backgroundColor: Colors.grey[800],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(
                              color,
                            ),
                      ),
                      Center(
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  progressText,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
