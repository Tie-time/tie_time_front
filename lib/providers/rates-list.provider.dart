import 'package:flutter/material.dart';
import 'package:tie_time_front/models/rate.model.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:tie_time_front/services/rate.service.dart';

class RateProvider with ChangeNotifier {
  final RateService _rateService;
  BuildContext? _context;
  List<Rate> _rates = [];

  RateProvider(this._rateService);

  List<Rate> get rates => _rates;

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

  Future<void> loadRates(DateTime date) async {
    _rates = await _rateService.rates(date.toString());
    print('Chargement des rates:');
    print('Nombre de rates: ${_rates.length}');
    _rates.forEach((rate) {
      print('Rate ID: ${rate.id}');
      print('Label: ${rate.label}');
      print('Score: ${rate.score}');
      print('TypeRate: ${rate.typeRate}');
      print('------------------------');
    });
    notifyListeners();
  }

  void _createRate(Rate rate, String newId) {
    Rate newRate = rate.copyWith(id: newId);
    final index = rates.indexWhere((t) => t.id == rate.id);
    if (index != -1) {
      _rates[index] = newRate;
      notifyListeners();
    }
  }

  void _updateRate(Rate rate) {
    final index = _rates.indexWhere((t) => t.id == rate.id);
    if (index != -1) {
      _rates[index] = rate;
      notifyListeners();
    }
  }

  void _deleteRate(Rate rate) {
    _rates.removeWhere((t) => t.id == rate.id);
    notifyListeners();
  }

  // void onEditingNewRate(DateTime date) {
  //   _rates.update(Rate(id: '', label: '', isEditing: true));
  //   notifyListeners();
  // }

  void handleRateTitleChange(Rate rate, DateTime date) {
    if (rate.id == null) {
      _handleCreateRate(rate, date);
    } else {
      _handleUpdateRate(rate);
    }
  }

  Future<void> _handleCreateRate(Rate rate, DateTime date) async {
    try {
      final result = await _rateService.createRate(rate, date.toString());
      _updateRate(rate);
    } catch (e) {
      _showError('$e');
    }
  }

  Future<void> _handleUpdateRate(Rate rate) async {
    try {
      await _rateService.updateRate(rate);
      _updateRate(rate);
    } catch (e) {
      _showError('$e');
    }
  }
}
