class CurrencyModel {
  final Map<String, dynamic> rates;
  
  CurrencyModel({required this.rates});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(rates: json['rates']);
  }
}
