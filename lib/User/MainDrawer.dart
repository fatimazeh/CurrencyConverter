import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency/User/AboutUs.dart';
import 'package:currency/User/CurrencyConversionHistory.dart';
import 'package:currency/User/ExchangeHistory.dart';
import 'package:currency/User/ExchangeRateInformation.dart';
import 'package:currency/User/Feedback.dart';
import 'package:currency/User/Guide.dart';
import 'package:currency/User/HelpCenter.dart';
import 'package:currency/User/MarketTrends.dart';
import 'package:currency/User/NewsandAlerts.dart';
import 'package:currency/User/NotificationList.dart';
import 'package:currency/User/Profile.dart';
import 'package:currency/User/SetThersholds.dart';
import 'package:currency/User/UserLogin.dart';
import 'package:currency/models/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String? _userName;
  String? _userImage;
  int _notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchNotificationCount(); // Fetch notification count on initialization
  }

  Future<void> _loadUserData() async {
    _userName = await SharedPreferenceshelper.getUserName();
    _userImage = await SharedPreferenceshelper.getUserImage();
    setState(() {});
  }

  Future<void> _fetchNotificationCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('isRead', isEqualTo: false)
          .get();

      setState(() {
        _notificationCount = snapshot.size; // Update notification count
      });
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  void _resetNotificationCount() {
    setState(() {
      _notificationCount = 0; // Reset notification count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF597CFF), // Blue
       Colors.white, // Dark Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent, // Transparent container to show gradient
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: <Widget>[
                  
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    
                     // White background
                    backgroundImage: _userImage != null
                        ? NetworkImage(_userImage!)
                        : null,
                    child: _userImage == null
                        ? Icon(Icons.person, size: 50, color: Colors.black) // Black icon if no image
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    
                    _userName ?? 'Welcome User',
                    style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold,  fontFamily: GoogleFonts.montserrat().fontFamily,), // White text color
                  ),
                ],
              ),
            ),
            buildListItem(
              context,
              "Conversion History",
              Icons.history,
              ConversionHistoryScreen(),
            ),
            buildListItem(
              context,
              "Notifications",
              Icons.notifications,
              NotificationListPage(onPageOpened: _resetNotificationCount),
              notificationCount: _notificationCount,
            ),
            buildListItem(
              context,
              "News and Alerts",
              Icons.newspaper,
              const NewsFeedPage(),
            ),
            // buildListItem(
            //   context,
            //   "Market Trends",
            //   Icons.trending_up,
            //   MarketTrendsPage(),
            // ),
            buildListItem(
              context,
              "Set Thresholds",
              Icons.settings,
              SetThresholdPage(),
            ),
            buildListItem(
              context,
              "Feedback",
              Icons.feedback,
              const FeedbackPage(),
            ),
            buildListItem(
              context,
              "About",
              Icons.info,
              const AboutPage(),
            ),
            buildListItem(
              context,
              "FAQ",
              Icons.help_outline,
              const FAQPage(),
            ),
            buildListItem(
              context,
              "Guide",
              Icons.book,
              CurrencyInfoPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget destination, {
    bool isLogout = false,
    int notificationCount = 0,
  }) {
    return ListTile(
      leading: Stack(
        children: [
          Icon(icon, color: Colors.black), // White icon color
          if (notificationCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: const BoxConstraints(minWidth: 24),
                child: Center(
                  child: Text(
                    '$notificationCount',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      tileColor: Colors.black, // Black background for ListTile
      textColor: Colors.black, // White text color
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black, // White text color
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        if (isLogout) {
          _handleLogout();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
    );
  }

  void _handleLogout() async {
    try {
      // Perform logout logic here (e.g., clearing user session)
      await SharedPreferenceshelper.clearUserData(); // Ensure this method exists and works

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Userlogin()),
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
