import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversionHistoryScreen extends StatefulWidget {
  @override
  _ConversionHistoryScreenState createState() =>
      _ConversionHistoryScreenState();
}

class _ConversionHistoryScreenState extends State<ConversionHistoryScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _userName = userDoc['name'] ?? 'Unknown User';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversion History',
          style: GoogleFonts.syne(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF597CFF), // Blue background
        leading: BackButton(
          color: Colors.white, // White color for the back button
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              
              Colors.white,
              Colors.white,
                Color(0xFF597CFF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_userName != null)
                Text(
                  'User: $_userName',
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF597CFF), // Blue color
                  ),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildConversionHistory(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversionHistory() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('No user logged in'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('conversions')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No conversion history found'));
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            DateTime timestamp = data['timestamp']?.toDate() ?? DateTime.now();
            String currencyCode = data['selected_currency'];

            // URL for the currency icon
            String iconUrl =
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD6mlBbKfN3OyZ8wzRIOCd_LUMmDeXl1hxbA&s';

            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                      color: const Color(0xFF597CFF)), // Blue border
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(iconUrl),
                    radius: 24,
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    '${data['amount_in_usd']} USD to ${data['converted_amount']} ${data['selected_currency']}',
                    style: GoogleFonts.libreCaslonText(
                      fontSize: 16,
                      color: Colors.black, // Blue color
                    ),
                  ),
                  subtitle: Text(
                    'Converted on ${timestamp.toLocal().toString()}',
                    style: GoogleFonts.libreCaslonText(
                      fontSize: 14,
                      color: Colors.black, // Blue color
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
