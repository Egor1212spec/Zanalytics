enum StoryType {
  topExpenses,
  goalProgress,
  achievement,
  videoLesson,
}

class StoryModel {
  final StoryType type;
  final Map<String, dynamic> data;

  StoryModel({required this.type, required this.data});
}
