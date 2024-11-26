import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceshelper {
  // Save user details
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  static Future<void> saveUserImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImage', imagePath);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  // Get user details
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  static Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userImage');
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Clear user data
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('userImage');
    await prefs.remove('userId');
  }

   // Save rate alerts
  static Future<void> saveRateAlerts(List<Map<String, dynamic>> alerts) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String alertsString = jsonEncode(alerts);
      await prefs.setString('rate_alerts', alertsString);
    } catch (e) {
      print('Error saving rate alerts: $e');
    }
  }

  // Get rate alerts
  static Future<List<Map<String, dynamic>>> getRateAlerts() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? alertsString = prefs.getString('rate_alerts');
      if (alertsString == null) {
        return [];
      }
      final List<dynamic> alertsJson = jsonDecode(alertsString);
      return alertsJson.map((json) => Map<String, dynamic>.from(json)).toList();
    } catch (e) {
      print('Error retrieving rate alerts: $e');
      return [];
    }
  }
}
