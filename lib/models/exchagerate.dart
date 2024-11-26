class CurrencyConversionRates {
  final Map<String, double> _conversionRates = {
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.50,
    'AUD': 1.35,
    'AED': 3.672538,
    'AFN': 66.809999,
    'ALL': 125.716501,
    'AMD': 484.902502,
    'ANG': 1.788575,
    'AOA': 135.295998,
    'ARS': 9.750101,
    'BHD': 0.410945,
    'INR': 91.766100,
    'BRL': 6.003489,
    'BGN': 1.955830,
    'CAD': 1.500937,
    'CLP': 1020.829762,
    'COP': 4428.138238,
    'CZK': 25.172217,
    'DKK': 7.463427,
    'HKD': 8.512939,
    'LYD': 5.251731,
    'MYR': 4.856798,
    'MUR': 50.652013,
    'MXN': 20.787530,
    'NPR': 146.894584,
    'NZD': 1.64, 
    'NOK': 10.80,
    'OMR': 3.978298,
    'PKR': 304.611516,
    'PHP': 62.323163,
    'PLN': 4.299662,
    'QAR': 3.978298,
    'SAR': 4.098521,
    'SGD': 1.446377,
    'ZAR': 19.920491,
    'KRW': 1498.429808,
    'LKR': 326.789257,
    'SEK': 11.498814,
    'CHF': 0.948218,
    'TWD': 35.452506,
    'THB': 38.437161,
    'TTD': 7.421254,
    'TRY': 36.696603,
    'USD': 1.092939,
    'VEF': 3998441.190866,
  };

  // Method to get the conversion rate for a specific currency
  double getRate(String currency) {
    return _conversionRates[currency] ?? 1.0; // Default to 1.0 if not found
  }

  // Method to get all the currency keys
  List<String> getCurrencies() {
    return _conversionRates.keys.toList();
  }
}
