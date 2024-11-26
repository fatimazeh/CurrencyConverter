import 'package:currency/LayoutScreen.dart';
import 'package:currency/User/AboutUs.dart';
import 'package:currency/User/CurrencyConverter.dart';
import 'package:currency/User/Guide.dart';
import 'package:currency/User/HomePage.dart';
import 'package:currency/User/MainDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAPccTWSMPU3ViasfTirtHtiCXbG0Utxc8",
        authDomain: "currensee-ca098.firebaseapp.com",
        projectId: "currensee-ca098",
        storageBucket: "currensee-ca098.appspot.com",
        messagingSenderId: "695533809309",
        appId: "1:695533809309:web:3944510b99c10f75332e74",
        measurementId: "G-1FF7TC1VL6",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBKQ8QT8XCNxr015R1r1bjsNqtfFyMZytI",
        appId: "1:695533809309:android:031033abee5a353b332e74",
        messagingSenderId: "695533809309",
        projectId: "currensee-ca098",
        // Ensure this is included if using Realtime Database
        // storageBucket:
        //     "photonicflux-4a550.appspot.com", // Ensure this is included if using Storage
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(

        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Syne', // Default font
   appBarTheme: const AppBarTheme(
  backgroundColor: Colors.transparent, // Set to transparent
  foregroundColor: Color(0xFF597CFF),
  titleTextStyle: TextStyle(
    fontFamily: 'Parisienne',
    fontSize: 25,
    color: Colors.white,
  ),
),

// Then, in your AppBar widget:

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:Color(0xFFFFE1DE), // Blue
          selectedItemColor:   Color(0xFF597CFF), // Lightest Blue
          unselectedItemColor:Color(0xFF597CFF),// Light Blue
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'LibreCaslonText',
            color:Color(0xFFFFE1DE),// Lightest Blue
          ),
          bodyMedium: TextStyle(
            fontFamily: 'LibreCaslonText',
            color:Color(0xFFFFE1DE) // Light Blue
          ),
        ),
        scaffoldBackgroundColor: Color(0xFFF0D2D0), // Purple
      ),
      home: const Layoutscreen(),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
    CurrencyConverterScreen(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  CurrencyInfoPage()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.align_horizontal_left_sharp, color:Color(0xFF597CFF)),
      ),
   appBar: PreferredSize(
  preferredSize: Size.fromHeight(56), // Default height of AppBar
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFE1DE),Color(0xFF597CFF), ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: AppBar(
      title: const Text('CurrenSee'),
      centerTitle: true,
      elevation: 0, // Remove default elevation
    ),
  ),
),
      drawer: const MainDrawer(),
      drawerScrimColor: Color(0xFFFFE1DE),
     backgroundColor:Color(0xFFFFE1DE),// Purple
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF597CFF)), // Lightest Blue
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop, color: Color(0xFF597CFF)), // Lightest Blue
            label: 'Converter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color:  Color(0xFF597CFF)), // Lightest Blue
            label: 'About',
          ),
        ],
      ),
    );
  }
}
