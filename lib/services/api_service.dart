import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl =
      'https://v6.exchangerate-api.com/v6/f901a070def94d03feedd0c9/latest/USD';

  Future<Map<String, dynamic>> fetchRates() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load currency data');
    }
  }
}
