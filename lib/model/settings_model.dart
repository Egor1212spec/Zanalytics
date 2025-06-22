import 'package:zanalytics/model/user_profile_data.dart';

class Settings {
  final UserProfileData user;
  Settings._internal(this.user);
  static late final Settings _instance;
  static void initialize(UserProfileData existingUser) {
    _instance = Settings._internal(existingUser);
  }

  static Settings get instance {
    assert(
      _instance != null,
      'Вызовите Settings.initialize() перед использованием',
    );
    return _instance;
  }

  factory Settings() => instance;
}
