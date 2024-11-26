import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency/models/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginUser extends StatefulWidget {
  static const String id = "LoginUser";
  const LoginUser({Key? key}) : super(key: key);

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  String userId = '';
  String userName = '';
  String userEmail = '';
  String userImage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    userId = await SharedPreferenceshelper.getUserId() ?? '';
    if (userId.isNotEmpty) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          setState(() {
            Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
            userName = data?['Name'] ?? '';
            userEmail = data?['Email'] ?? '';
            userImage = data?['Image'] ?? '';
          });
        }
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to fetch user data: ${e.toString()}"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: GoogleFonts.libreCaslonText(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF597CFF), // Blue
        elevation: 0, // Remove shadow
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white, Color(0xFF597CFF)], // Gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: userId.isEmpty
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userImage),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userName,
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF001F3D), // Dark Blue
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userEmail,
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // Log out and navigate to the login screen
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF001F3D), // Dark Blue
                        ),
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.libreCaslonText(
                            color: Colors.white, // Light Pink
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
