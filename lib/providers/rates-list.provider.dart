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
    notifyListeners();
  }

  void _createRate(Rate rate, String newId) {
    Rate newRate = rate.copyWith(id: newId);
    final index = rates.indexWhere((t) => t.typeRate == rate.typeRate);
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
    final resetRate = rate.copyWith(id: '', score: 0);
    final index = rates.indexWhere((t) => t.typeRate == rate.typeRate);
    if (index != -1) {
      _rates[index] = resetRate;
      notifyListeners();
      print("DELETE RATE");
      print(_rates[index].id);
    }
  }

  // void onEditingNewRate(DateTime date) {
  //   _rates.update(Rate(id: '', label: '', isEditing: true));
  //   notifyListeners();
  // }

  void handleRateScoreChange(Rate rate, DateTime date) {
    if (rate.id == '') {
      _handleCreateRate(rate, date);
    } else {
      _handleUpdateRate(rate);
    }
  }

  Future<void> _handleCreateRate(Rate rate, DateTime date) async {
    try {
      final result = await _rateService.createRate(rate, date.toString());
      _createRate(rate, result["rate"]["id"]);
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

  Future<void> handleDeleteRate(Rate rate) async {
    try {
      if (rate.id == '') {
        throw Exception('Impossible de supprimer une tâche non enregistrée');
      }
      await _rateService.deleteRate(rate.id);
      _deleteRate(rate);
      _showSuccess('Note supprimée avec succès');
    } catch (e) {
      _showError('$e');
    }
  }
}
