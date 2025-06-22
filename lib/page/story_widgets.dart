import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class TopExpensesStoryWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const TopExpensesStoryWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String title =
        data['title'] ?? 'Твои топ-3 траты на неделе:';
    final List<Map<String, String>> expenses =
        List<Map<String, String>>.from(
          data['expenses'] ?? [],
        );

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ...expenses.map(
              (expense) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      expense['icon']!,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      expense['name']!,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalProgressStoryWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const GoalProgressStoryWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String title =
        data['title'] ?? 'Ты почти у цели!';
    final String goalIcon = data['goalIcon'] ?? '👟';
    final String subtitle = data['subtitle'] ?? '';
    final double progress = data['progress'] ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              goalIcon,
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  backgroundColor: Colors.grey.shade800,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(
                        Colors.lightBlueAccent,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${(progress * 100).toStringAsFixed(0)}% накоплено',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementStoryWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  const AchievementStoryWidget({
    super.key,
    required this.data,
  });

  @override
  State<AchievementStoryWidget> createState() =>
      _AchievementStoryWidgetState();
}

class _AchievementStoryWidgetState
    extends State<AchievementStoryWidget> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        widget.data['title'] ?? 'Новая ачивка!';
    final String icon = widget.data['icon'] ?? '✨';
    final String subtitle = widget.data['subtitle'] ?? '';

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  icon,
                  style: const TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),

        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality:
              BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
          ],
          createParticlePath: (size) {
            return Path()..addOval(
              Rect.fromCircle(
                center: Offset.zero,
                radius: 8,
              ),
            );
          },
        ),
      ],
    );
  }
}
