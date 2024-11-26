import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/currency_model.dart';

class CurrencyProvider with ChangeNotifier {
   CurrencyModel? _currencyModel;
  bool _isLoading = false;

  CurrencyProvider() {
    _fetchCurrencyData();
  }

  bool get isLoading => _isLoading;
  CurrencyModel? get currencyModel => _currencyModel;

  Future<void> _fetchCurrencyData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final ApiService apiService = ApiService();
      final data = await apiService.fetchRates();
      _currencyModel = CurrencyModel.fromJson(data);
    } catch (e) {
      // Handle the error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
