// lib/fin_story_screen.dart
import 'package:flutter/material.dart';
import '../model/story_model.dart';
import 'story_widgets.dart';
import 'package:video_player/video_player.dart';

class FinStoryScreen extends StatefulWidget {
  const FinStoryScreen({super.key});

  @override
  State<FinStoryScreen> createState() =>
      _FinStoryScreenState();
}

class _FinStoryScreenState extends State<FinStoryScreen> {
  final PageController _pageController = PageController();
  late final List<StoryModel> _stories;
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
    }
    if (index == 2) {
      Navigator.popAndPushNamed(context, '/quiz');
    }
    if (index == 3) {
      Navigator.popAndPushNamed(context, '/friends');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStories();
  }

  void _loadStories() {
    _stories = [
      StoryModel(
        type: StoryType.topExpenses,
        data: {
          'title': 'Твой топ-3 трат на этой неделе:',
          'expenses': [
            {'icon': '🎮', 'name': 'Steam'},
            {'icon': '🍔', 'name': 'Вкусно и Точка'},
            {'icon': '🚌', 'name': 'Проездной'},
          ],
        },
      ),
      StoryModel(
        type: StoryType.goalProgress,
        data: {
          'title': 'Ты почти у цели!',
          'goalIcon': '👟',
          'subtitle':
              'До новых кроссовок осталось накопить 2250 ₽. Если не будешь покупать газировку 3 раза, накопишь уже в пятницу!',
          'progress': 0.85,
        },
      ),
      StoryModel(
        type: StoryType.achievement,
        data: {
          'title': 'Новая ачивка!',
          'icon': '✨',
          'subtitle':
              '«Соня-полуночница». Ты не совершал трат после 22:00 три дня подряд. Твои сбережения растут, пока ты спишь!',
        },
      ),
      StoryModel(
        type: StoryType.videoLesson,
        data: {
          'videoAsset': 'assets/lessons/saving_ps5.mp4',
        },
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: _stories.length + 1,
        onPageChanged: (index) {
          if (index == _stories.length) {
            _pageController.jumpToPage(0);
          }
        },
        itemBuilder: (context, index) {
          if (index == _stories.length) {
            return Container();
          }
          final story = _stories[index % _stories.length];
          switch (story.type) {
            case StoryType.topExpenses:
              return TopExpensesStoryWidget(
                data: story.data,
              );
            case StoryType.goalProgress:
              return GoalProgressStoryWidget(
                data: story.data,
              );
            case StoryType.achievement:
              return AchievementStoryWidget(
                data: story.data,
              );
            case StoryType.videoLesson:
              return VideoLessonStoryWidget(
                data: story.data,
              );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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

class VideoLessonStoryWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  const VideoLessonStoryWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<VideoLessonStoryWidget> createState() =>
      _VideoLessonStoryWidgetState();
}

class _VideoLessonStoryWidgetState
    extends State<VideoLessonStoryWidget> {
  late VideoPlayerController _controller;
  bool _isLiked = false;
  @override
  void initState() {
    super.initState();
    final String videoAsset = widget.data['videoAsset'];
    _controller = VideoPlayerController.asset(videoAsset)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller.value.isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          _buildUIOverlay(),
        ],
      ),
    );
  }

  Widget _buildUIOverlay() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: AnimatedOpacity(
            opacity: _controller.value.isPlaying
                ? 0.0
                : 1.0,
            duration: const Duration(milliseconds: 300),
            child: const Center(
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 80.0,
                shadows: [
                  Shadow(
                    blurRadius: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            20.0,
          ).copyWith(bottom: 40.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.amber[800]!,
                        bufferedColor: Colors.white54,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          _isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _isLiked
                              ? Colors.redAccent
                              : Colors.white,
                          size: 35.0,
                          shadows: const [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Лайк",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
