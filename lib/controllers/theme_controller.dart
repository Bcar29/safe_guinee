import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  bool _theme = false;
  bool get theme => _theme;

  void changTheme() {
    _theme = !_theme;
    notifyListeners();
  }
}
