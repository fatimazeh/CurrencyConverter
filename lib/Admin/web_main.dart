import 'package:currency/Admin/Dashboard.dart';
import 'package:currency/Admin/History.dart';
import 'package:currency/Admin/LoginUser.dart';
import 'package:currency/Admin/NewsandAlerts.dart';
import 'package:currency/Admin/NotificationPage.dart';

import 'package:currency/Admin/RegisteredUser.dart';
import 'package:currency/Admin/Thersholds.dart';
import 'package:currency/Admin/UserContact.dart';
import 'package:currency/Admin/UserFeedbacks.dart';
import 'package:currency/models/shared_pref_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMain extends StatefulWidget {
  const WebMain({Key? key}) : super(key: key);
  static const String id = "WebMain";

  @override
  State<WebMain> createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  Widget _selectedScreen = const AdminDashboard();
  String _adminName = 'Admin'; // Default name

  final List<Color> _gradientColors = [
    Color(0xFF597CFF),
    Colors.white,
    Colors.white,
  ];

  String _selectedRoute = AdminDashboard.id;

  @override
  void initState() {
    super.initState();
    _fetchAdminName();
  }

  Future<void> _fetchAdminName() async {
    final name = await SharedPreferenceHelper().getAdminData();
    if (name != null && name.isNotEmpty) {
      setState(() {
        _adminName = name;
      });
    }
  }

  void _chooseScreen(String? route) {
    setState(() {
      _selectedRoute = route ?? AdminDashboard.id;
      switch (_selectedRoute) {
        case AdminDashboard.id:
          _selectedScreen = const AdminDashboard();
          break;
        case AdminNotificationPage.id:
          _selectedScreen = const AdminNotificationPage();
          break;
        case LoginUser.id:
          _selectedScreen = const LoginUser();
          break;
        case ConversionHistoryScreen.id:
          _selectedScreen =  ConversionHistoryScreen();
          break;
        case RegisteredUsers.id:
          _selectedScreen = const RegisteredUsers();
          break;
        case FeedbackListPage.id:
          _selectedScreen = const FeedbackListPage();
          break;
        case UserThresholdsList.id:
          _selectedScreen = UserThresholdsList();
          break;
                  case ContactListPage.id:
          _selectedScreen = const ContactListPage();
          break;
      
        case NewsAndArticlesPage.id:
          _selectedScreen = const NewsAndArticlesPage();
          break;
        default:
          _selectedScreen = const AdminDashboard();
      }
    });
  }

  void _logout() {
    // Implement your logout logic here
    SharedPreferenceHelper().clearAdminData(); // Clear stored admin data
    Navigator.pushReplacementNamed(context, '/login'); // Update with your login route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the AppBar background color to white
        centerTitle: true,
        title: Stack(
          children: [
            // Centered Text
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Welcome, $_adminName!",
                    style: const TextStyle(
                      color: Color(0xFF597CFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Your Control Hub Awaits!",
                    style: TextStyle(
                      color: Color(0xFF597CFF),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            // Positioned Logo
            Positioned(
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset(
                  '../lib/images/staticbanner.jpg', // Replace with your logo path
                  height: 40, // Adjust the height as needed
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF597CFF)), // Menu button
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Open the side drawer
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF597CFF)), // Settings/menu button
            onSelected: (value) {
              switch (value) {
                case 'User Panel':
                  Navigator.pushNamed(context, '/userPanel'); // Replace with your User Panel route
                  break;
                case 'About':
                  Navigator.pushNamed(context, '/about'); // Replace with your About page route
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'User Panel',
                  child: Text('User Panel'),
                ),
                const PopupMenuItem<String>(
                  value: 'About',
                  child: Text('About'),
                ),
              ];
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF597CFF)), // Logout button
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Container(
          color: Colors.white, // Background color for the drawer
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the drawer header
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 130, // Adjust the size of the logo
                height: 80, // Adjust the size of the logo
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('../lib/images/Logo.gif'), // Ensure this path is correct
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _buildDrawerItem(
                      icon: Icons.dashboard,
                      title: 'Dashboard',
                      route: AdminDashboard.id,
                    ),
                    _buildDrawerItem(
                      icon: Icons.notifications,
                      title: 'Add Notifications',
                      route: AdminNotificationPage.id,
                    ),
                    _buildDrawerItem(
                      icon: Icons.feedback,
                      title: 'Feedbacks',
                      route: FeedbackListPage.id,
                    ),
                        _buildDrawerItem(
                      icon: Icons.feedback,
                      title: 'User Contact',
                      route: ContactListPage.id,
                    ),
                    _buildDrawerItem(
                      icon: Icons.warning,
                      title: 'Thresholds',
                      route: UserThresholdsList.id,
                    ),
                    _buildDrawerItem(
                      icon: Icons.person,
                      title: 'Registered Users',
                      route: RegisteredUsers.id,
                    ),
                    _buildDrawerItem(
                      icon: Icons.history,
                      title: 'Conversion History',
                      route: ConversionHistoryScreen.id,
                    ),
                  
                    _buildDrawerItem(
                      icon: Icons.article,
                      title: 'News and Articles',
                      route: NewsAndArticlesPage.id,
                    ),
                    _buildDrawerItem(
                      icon: Icons.person_outline,
                      title: 'User Info List',
                      route: LoginUser.id,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF597CFF), Colors.black, Colors.black], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AdminScaffold(
          sideBar: SideBar(
            iconColor: Color(0xFF597CFF),
            textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            onSelected: (item) => _chooseScreen(item.route),
            items: const [
              AdminMenuItem(
                title: "Dashboard",
                icon: Icons.dashboard,
                route: AdminDashboard.id,
              ),
              AdminMenuItem(
                title: "Manage Notifications",
                icon: Icons.notifications,
                route: AdminNotificationPage.id,
              ),
              AdminMenuItem(
                title: "Registered Users",
                icon: Icons.person,
                route: RegisteredUsers.id,
              ),
              AdminMenuItem(
                title: "User Info List",
                icon: Icons.person_outline,
                route: LoginUser.id,
              ),
              AdminMenuItem(
                title: "Thresholds",
                icon: Icons.warning,
                route: UserThresholdsList.id,
              ),
              AdminMenuItem(
                title: "Conversion History",
                icon: Icons.history,
                route: ConversionHistoryScreen.id,
              ),
            
              AdminMenuItem(
                title: "User Feedbacks",
                icon: Icons.feedback,
                route: FeedbackListPage.id,
              ),
                       AdminMenuItem(
                title: "User Contact",
                icon: Icons.warning,
                route: ContactListPage.id,
              ),
              AdminMenuItem(
                title: "News and Articles",
                icon: Icons.article,
                route: NewsAndArticlesPage.id,
              ),
            ],
            selectedRoute: _selectedRoute,
            backgroundColor: Colors.white,
            activeTextStyle: const TextStyle(color: Color(0xFF597CFF)),
          ),
          body: _selectedScreen,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String route,
  }) {
    final bool isSelected = route == _selectedRoute;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Color(0xFF597CFF) : Colors.black), // Selected icon color
      title: Text(title, style: TextStyle(color: isSelected ? Color(0xFF597CFF) : Colors.black)), // Selected text color
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
