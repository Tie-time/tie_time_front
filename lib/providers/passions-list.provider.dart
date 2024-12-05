import 'package:flutter/material.dart';
import 'package:tie_time_front/models/passion.model.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:tie_time_front/services/passion.service.dart';

class PassionProvider with ChangeNotifier {
  final PassionService _passionService;
  BuildContext? _context;
  List<Passion> _passions = [];

  PassionProvider(this._passionService);

  List<Passion> get passions => _passions;

  void setContext(BuildContext context) {
    _context = context;
  }

// Utiliser le context stocké dans les méthodes
  void _showError(String message) {
    if (_context != null) {
      MessageService.showErrorMessage(_context!, message);
    }
  }

// Utiliser le context stocké dans les méthodes
  void _showSuccess(String message) {
    if (_context != null) {
      MessageService.showSuccesMessage(_context!, message);
    }
  }

  Future<void> loadPassions(DateTime date) async {
    _passions = await _passionService.passions(date.toString());
    notifyListeners();
  }

  void _checkPassion(Passion passion) {
    Passion newPassion = passion.copyWith(isChecked: !passion.isChecked);
    final index = _passions.indexWhere((t) => t.id == passion.id);
    if (index != -1) {
      _passions[index] = newPassion;
      notifyListeners();
    }
  }

  Future<void> handleCheckPassion(Passion passion) async {
    try {
      // await _passionService.checkPassion(task.id);
      _checkPassion(passion);
    } catch (e) {
      _showError('$e');
    }
  }
}
