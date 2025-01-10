import 'package:flutter/material.dart';
import '../models/settings.model.dart';

class SettingsProvider with ChangeNotifier {
  Settings _settings = Settings(
    maxTasks: 5,
    passions: [],
  );

  Settings get settings => _settings;

  void updateMaxTasks(int value) {
    _settings = _settings.copyWith(maxTasks: value);
    notifyListeners();
  }

  void updatePassion(PassionSettings passion) {
    final updatedPassions = _settings.passions.map((p) {
      if (p.id == passion.id) {
        return passion;
      }
      return p;
    }).toList();

    _settings = _settings.copyWith(passions: updatedPassions);
    notifyListeners();
  }
}
