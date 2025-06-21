// Вставьте этот класс в ваш файл main.dart

import 'package:flutter/material.dart';

/// Класс-модель для одного достижения.
class Achievement {
  final String name;
  final String description;
  final IconData iconData;
  const Achievement({
    required this.name,
    required this.description,
    required this.iconData,
  });
}
