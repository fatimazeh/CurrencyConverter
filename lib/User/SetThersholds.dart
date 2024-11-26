import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetThresholdPage extends StatefulWidget {
  @override
  _SetThresholdPageState createState() => _SetThresholdPageState();
}

class _SetThresholdPageState extends State<SetThresholdPage> {
  final TextEditingController _thresholdController = TextEditingController();
  final List<String> _currencyPairs = [
    'USD/JPY', 'EUR/USD', 'GBP/USD', 'AUD/USD', 'USD/CAD', 'EUR/GBP',
    'GBP/EUR', 'JPY/USD', 'AUD/JPY', 'AED/USD', 'AFN/USD', 'ALL/USD',
    'AMD/USD', 'ANG/USD', 'AOA/USD', 'ARS/USD', 'BHD/USD', 'INR/USD',
    'BRL/USD', 'BGN/USD', 'CAD/JPY', 'CLP/USD', 'COP/USD', 'CZK/USD',
    'DKK/USD', 'HKD/USD', 'LYD/USD', 'MYR/USD', 'MUR/USD', 'MXN/USD',
    'NPR/USD', 'NZD/USD', 'NOK/USD', 'OMR/USD', 'PKR/USD', 'PHP/USD',
    'PLN/USD', 'QAR/USD', 'SAR/USD', 'SGD/USD', 'ZAR/USD', 'KRW/USD',
    'LKR/USD', 'SEK/USD', 'CHF/USD', 'TWD/USD', 'THB/USD', 'TTD/USD',
    'TRY/USD', 'USD/VEF'
  ];

  String? _selectedCurrencyPair;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:    AppBar(
  title: Text(
    'Set Threshold',
    style: GoogleFonts.syne(color: Colors.white),
  ),
  backgroundColor: const Color(0xFF597CFF),
  iconTheme: IconThemeData(color: Colors.white), // Set back button color to white
),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white, Color(0xFF597CFF),],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set a Threshold for Currency Pair',
              style: GoogleFonts.libreCaslonText(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:const Color(0xFF597CFF),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCurrencyPair,
              hint: const Text('Select Currency Pair'),
              items: _currencyPairs.map((pair) {
                return DropdownMenuItem<String>(
                  value: pair,
                  child: Text(pair),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCurrencyPair = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _thresholdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Threshold',
                prefixIcon: Icon(Icons.trending_up, color: Color(0xFF566777)),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.black), // Set text color to black
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setThreshold,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF597CFF),
              ),
              child: Text('Set Threshold', style: GoogleFonts.libreCaslonText(color: Colors.white)),
            ),
            const SizedBox(height: 40),
            Text(
              'Your Thresholds',
              style: GoogleFonts.libreCaslonText(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildThresholdList()),
          ],
        ),
      ),
    );
  }

  void _setThreshold() async {
    String? currencyPair = _selectedCurrencyPair;
    double threshold = double.tryParse(_thresholdController.text) ?? 0.0;

    if (currencyPair != null && threshold > 0) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Map<String, dynamic> alertData = {
          'currency_pair': currencyPair,
          'threshold': threshold,
          'timestamp': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('thresholds')
            .add(alertData)
            .then((value) => print('Threshold Set'))
            .catchError((error) => print('Failed to set threshold: $error'));

        _showPopup(context, 'Threshold set for $currencyPair at $threshold');
        _thresholdController.clear();
      } else {
        print('No user logged in');
      }
    } else {
      _showPopup(context, 'Please select a currency pair and enter a valid threshold');
    }
  }

void _showPopup(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,  // Set the background color
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF597CFF)),  // Icon in the title
            SizedBox(width: 10),
            Text(
              'Threshold Set',
              style: GoogleFonts.libreCaslonText(
                color: const Color(0xFF597CFF),  // Set the title text color
              ),
            ),
          ],
        ),
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF597CFF)),  // Icon in the content
            SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.libreCaslonText(
                  color: const Color(0xFF597CFF),  // Set the content text color
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'OK',
              style: GoogleFonts.libreCaslonText(
                color: Colors.black, 
                fontWeight: FontWeight.bold, // Set the button text color
              ),
            ),
          ),
        ],
      );
    },
  );
}


  Widget _buildThresholdList() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(child: Text('No user logged in'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('thresholds')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No thresholds set yet.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            String currencyPair = data['currency_pair'];
            double threshold = data['threshold'];
            Timestamp? timestamp = data['timestamp'] as Timestamp?;

            return _buildCard(currencyPair, threshold, timestamp);
          }).toList(),
        );
      },
    );
  }

  Widget _buildCard(String currencyPair, double threshold, Timestamp? timestamp) {
    String iconUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD6mlBbKfN3OyZ8wzRIOCd_LUMmDeXl1hxbA&s';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: const Color(0xFF597CFF)),
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
            '$currencyPair - $threshold',
            style: GoogleFonts.libreCaslonText(
              fontSize: 18,
              color: const Color(0xFF001F3D),
            ),
          ),
          subtitle: Text(
            'Set on: ${timestamp != null ? timestamp.toDate().toString() : 'N/A'}',
            style: GoogleFonts.libreCaslonText(
              fontSize: 14,
              color: const Color(0xFF566777),
            ),
          ),
        ),
      ),
    );
  }
}
