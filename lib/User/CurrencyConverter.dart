import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0.0;
  String _selectedCurrency = 'EUR'; // Default selected currency

  final Map<String, double> _conversionRates = {
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.50,
    'AUD': 1.35,
    'AED': 3.672538,
    'AFN': 66.809999,
    'ALL': 125.716501,
    'AMD': 484.902502,
    'ANG': 1.788575,
    'AOA': 135.295998,
    'ARS': 9.750101,
    'BHD': 0.410945,
    'INR': 91.766100,
    'BRL': 6.003489,
    'BGN': 1.955830,
    'CAD': 1.500937,
    'CLP': 1020.829762,
    'COP': 4428.138238,
    'CZK': 25.172217,
    'DKK': 7.463427,
    'HKD': 8.512939,
    'LYD': 5.251731,
    'MYR': 4.856798,
    'MUR': 50.652013,
    'MXN': 20.787530,
    'NPR': 146.894584,
    'NZD': 1.64,
    'NOK': 10.80,
    'OMR': 3.978298,
    'PKR': 304.611516,
    'PHP': 62.323163,
    'PLN': 4.299662,
    'QAR': 3.978298,
    'SAR': 4.098521,
    'SGD': 1.446377,
    'ZAR': 19.920491,
    'KRW': 1498.429808,
    'LKR': 326.789257,
    'SEK': 11.498814,
    'CHF': 0.948218,
    'TWD': 35.452506,
    'THB': 38.437161,
    'TTD': 7.421254,
    'TRY': 36.696603,
    'USD': 1.092939,
    'VEF': 3998441.190866,
  };

  void _convertCurrency() async {
    double rate = _conversionRates[_selectedCurrency] ?? 1.0;
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    setState(() {
      _convertedAmount = amount * rate;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic> conversionData = {
        'amount_in_usd': amount,
        'selected_currency': _selectedCurrency,
        'converted_amount': _convertedAmount,
        'timestamp': FieldValue.serverTimestamp(),
      };

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('conversions')
          .add(conversionData)
          .then((value) => print('Conversion Data Added'))
          .catchError((error) => print('Failed to add conversion data: $error'));
    } else {
      print('No user logged in');
    }
  }

  void _showSearch() async {
    final String? selectedCurrency = await showSearch<String>(
      context: context,
      delegate: CurrencySearchDelegate(
          _conversionRates.keys.toList(), _selectedCurrency),
    );

    if (selectedCurrency != null) {
      setState(() {
        _selectedCurrency = selectedCurrency;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light Pink background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
         begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
             Colors.white,
Colors.white,
              Colors.white,
                            Color(0xFF597CFF), // Blue
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Adjust padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Text(
                'Currency Converter',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 20),

              // Amount Input Field
              Text(
                'Amount in USD',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _amountController,
                style: GoogleFonts.libreCaslonText(color: Colors.black),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter amount in USD',
                  prefixIcon: Icon(Icons.attach_money, color: Colors.black),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),

              // Currency Dropdown
              Text(
                'Select currency',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _showSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black), // Black border
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFE1DED7), // Light Brown background
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedCurrency,
                          style: GoogleFonts.libreCaslonText(
                              fontSize: 16, color: Colors.black), // Black text
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Convert Button
              Center(
                child: ElevatedButton(
                  onPressed: _convertCurrency,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF597CFF), // Light Blue color
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Convert',
                    style: GoogleFonts.libreCaslonText(
                        fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Converted Amount Display
              Text(
                'Converted Amount:',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Black color
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0D2D0), // Pink color
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '$_convertedAmount $_selectedCurrency',
                  style: GoogleFonts.libreCaslonText(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black color
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Image at the bottom
         
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencySearchDelegate extends SearchDelegate<String> {
  final List<String> currencies;
  final String selectedCurrency;

  CurrencySearchDelegate(this.currencies, this.selectedCurrency);

  @override
  String? get searchFieldLabel => 'Search currencies';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> results = currencies
        .where(
            (currency) => currency.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
    begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
                 Color(0xFF597CFF), 

          ],
        ),
      ),
      child: ListView(
        children: results.map((currency) {
          return ListTile(
            title: Text(currency, style: GoogleFonts.libreCaslonText(color: Colors.black)),
            onTap: () {
              Navigator.pop(context, currency);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = currencies
        .where(
            (currency) => currency.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
 begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [
            // Blue
            Colors.white,
              Color(0xFFFFE1DE),
                Color(0xFF597CFF),
          ],
        ),
      ),
      child: ListView(
        children: suggestions.map((currency) {
          return ListTile(
            title: Text(currency, style: GoogleFonts.libreCaslonText(color: Colors.black)),
            onTap: () {
              Navigator.pop(context, currency);
            },
          );
        }).toList(),
      ),
    );
  }
}
