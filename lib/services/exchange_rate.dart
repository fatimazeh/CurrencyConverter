import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your API key
  final String apiUrl = 'https://v6.exchangerate-api.com/v6/';

  Future<Map<String, dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey/latest/USD'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
