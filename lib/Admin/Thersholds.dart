import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserThresholdsList extends StatelessWidget {
  static const String id = "UserThresholdsList";

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Thresholds',
       style: TextStyle(color: Colors.white),
        ),
        backgroundColor:  Color(0xFF597CFF), // Dark Blue
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,  // Light Blue
              Colors.white,  // Light Pink
              Colors.white, 
               Color(0xFF597CFF),// White
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: user != null ? _buildThresholdList(user) : _buildNoUserMessage(),
      ),
    );
  }

  Widget _buildNoUserMessage() {
    return Center(
      child: Text(
        'No user logged in',
        style: GoogleFonts.libreCaslonText(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildThresholdList(User user) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('thresholds')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No thresholds found'));
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            DateTime timestamp = data['timestamp']?.toDate() ?? DateTime.now();
            String currencyPair = data['currency_pair'];
            double threshold = data['threshold'];

            // Placeholder URL for the currency icon
            String iconUrl =
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD6mlBbKfN3OyZ8wzRIOCd_LUMmDeXl1hxbA&s';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Light Brown
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(iconUrl),
                    radius: 24,
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    'Threshold: $threshold for $currencyPair',
                    style: GoogleFonts.libreCaslonText(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Set on: ${timestamp.toLocal().toString()}',
                    style: GoogleFonts.libreCaslonText(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
