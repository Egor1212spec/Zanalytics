class Settings {
  // ИЗМЕНЕНИЕ: Заменяем bool на ValueNotifier<bool>
  // Это специальный класс, который уведомляет "слушателей" об изменении своего значения.
  // final darkMode = ValueNotifier<bool>(true);

  // Синглтон остается как есть
  Settings._internal();
  static final Settings _instance = Settings._internal();
  static Settings get instance => _instance;
  factory Settings() => _instance;
}
