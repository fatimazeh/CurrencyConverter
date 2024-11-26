import 'package:currency/User/ExchangeHistory.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ExchangeRateInformationPage extends StatefulWidget {
  @override
  _ExchangeRateInformationPageState createState() =>
      _ExchangeRateInformationPageState();
}

class _ExchangeRateInformationPageState
    extends State<ExchangeRateInformationPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedCurrency = 'EUR'; // Default currency for detailed view
  Map<String, dynamic>? _currentRate;
  List<Map<String, dynamic>> _historicalRates = [];

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

  final Map<String, Map<String, String>> _currencyInfo = {
    'EUR': {'name': 'Euro', 'symbol': '€'},
    'GBP': {'name': 'British Pound', 'symbol': '£'},
    'JPY': {'name': 'Japanese Yen', 'symbol': '¥'},
    'AUD': {'name': 'Australian Dollar', 'symbol': '\$'},
    'AED': {'name': 'United Arab Emirates Dirham', 'symbol': 'د.إ'},
    'AFN': {'name': 'Afghan Afghani', 'symbol': '؋'},
    'ALL': {'name': 'Albanian Lek', 'symbol': 'L'},
    'AMD': {'name': 'Armenian Dram', 'symbol': '֏'},
    'ANG': {'name': 'Netherlands Antillean Guilder', 'symbol': 'ƒ'},
    'AOA': {'name': 'Angolan Kwanza', 'symbol': 'Kz'},
    'ARS': {'name': 'Argentine Peso', 'symbol': '\$'},
    'BHD': {'name': 'Bahraini Dinar', 'symbol': '.د.ب'},
    'INR': {'name': 'Indian Rupee', 'symbol': '₹'},
    'BRL': {'name': 'Brazilian Real', 'symbol': 'R\$'},
    'BGN': {'name': 'Bulgarian Lev', 'symbol': 'лв'},
    'CAD': {'name': 'Canadian Dollar', 'symbol': 'C\$'},
    'CLP': {'name': 'Chilean Peso', 'symbol': '\$'},
    'COP': {'name': 'Colombian Peso', 'symbol': '\$'},
    'CZK': {'name': 'Czech Koruna', 'symbol': 'Kč'},
    'DKK': {'name': 'Danish Krone', 'symbol': 'kr'},
    'HKD': {'name': 'Hong Kong Dollar', 'symbol': 'HK\$'},
    'LYD': {'name': 'Libyan Dinar', 'symbol': 'ل.د'},
    'MYR': {'name': 'Malaysian Ringgit', 'symbol': 'RM'},
    'MUR': {'name': 'Mauritian Rupee', 'symbol': '₨'},
    'MXN': {'name': 'Mexican Peso', 'symbol': '\$'},
    'NPR': {'name': 'Nepalese Rupee', 'symbol': '₨'},
    'NZD': {'name': 'New Zealand Dollar', 'symbol': 'NZ\$'},
    'NOK': {'name': 'Norwegian Krone', 'symbol': 'kr'},
    'OMR': {'name': 'Omani Rial', 'symbol': 'ر.ع.'},
    'PKR': {'name': 'Pakistani Rupee', 'symbol': '₨'},
    'PHP': {'name': 'Philippine Peso', 'symbol': '₱'},
    'PLN': {'name': 'Polish Zloty', 'symbol': 'zł'},
    'QAR': {'name': 'Qatari Rial', 'symbol': 'ر.ق'},
    'SAR': {'name': 'Saudi Riyal', 'symbol': 'ر.س'},
    'SGD': {'name': 'Singapore Dollar', 'symbol': 'S\$'},
    'ZAR': {'name': 'South African Rand', 'symbol': 'R'},
    'KRW': {'name': 'South Korean Won', 'symbol': '₩'},
    'LKR': {'name': 'Sri Lankan Rupee', 'symbol': '₨'},
    'SEK': {'name': 'Swedish Krona', 'symbol': 'kr'},
    'CHF': {'name': 'Swiss Franc', 'symbol': 'CHF'},
    'TWD': {'name': 'New Taiwan Dollar', 'symbol': 'NT\$'},
    'THB': {'name': 'Thai Baht', 'symbol': '฿'},
    'TTD': {'name': 'Trinidad and Tobago Dollar', 'symbol': 'TT\$'},
    'TRY': {'name': 'Turkish Lira', 'symbol': '₺'},
    'USD': {'name': 'United States Dollar', 'symbol': '\$'},
    'VEF': {'name': 'Venezuelan Bolívar', 'symbol': 'Bs'},
  };

  @override
  void initState() {
    super.initState();
    _fetchCurrentRate();
  }

  void _fetchCurrentRate() async {
    DocumentSnapshot snapshot = await _firestore
        .collection('exchangeRates')
        .doc(_selectedCurrency)
        .get();

    setState(() {
      _currentRate = snapshot.data() as Map<String, dynamic>?;
    });
  }

  void _changeCurrency(String newCurrency) {
    setState(() {
      _selectedCurrency = newCurrency;
      _fetchCurrentRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EBE6), // Light Pink background
      appBar: AppBar(
        title: Text(
          'Exchange Rate Information',
          style: GoogleFonts.libreCaslonText(
            color: const Color(0xFF566777), // Dark Blue color
          ),
        ),
        backgroundColor: const Color(0xFFE1DED7), // Light Brown background
        iconTheme: IconThemeData(color: const Color(0xFF566777)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Exchange Rate Information
            Text(
              'Current Exchange Rate for $_selectedCurrency',
              style: GoogleFonts.libreCaslonText(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF566777), // Dark Blue color
              ),
            ),
            const SizedBox(height: 10),
            if (_currentRate != null)
              Card(
                color: const Color(0xFFE1DED7), // Light Brown background
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rate: ${_currentRate!['rate']}',
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 16,
                          color: const Color(0xFF001F3D), // Dark Blue color
                        ),
                      ),
                      Text(
                        'Last Updated: ${_currentRate!['last_updated']}',
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 14,
                          color: const Color(0xFF566777), // Light Blue color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Currency Selection Dropdown
            DropdownButton<String>(
              value: _selectedCurrency,
              onChanged: (newCurrency) {
                if (newCurrency != null) {
                  _changeCurrency(newCurrency);
                }
              },
              items: _conversionRates.keys
                  .map<DropdownMenuItem<String>>((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(
                    '$currency - ${_currencyInfo[currency]!['name']}',
                    style: GoogleFonts.libreCaslonText(
                      fontSize: 16,
                      color: const Color(0xFF001F3D), // Dark Blue color
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Historical Rates Section
            Expanded(
              child: ListView.builder(
                itemCount: _historicalRates.length,
                itemBuilder: (context, index) {
                  final rate = _historicalRates[index];
                  return ListTile(
                    title: Text(
                      'Rate: ${rate['rate']}',
                      style: GoogleFonts.libreCaslonText(
                        color: const Color(0xFF001F3D), // Dark Blue color
                      ),
                    ),
                    subtitle: Text(
                      'Date: ${rate['date']}',
                      style: GoogleFonts.libreCaslonText(
                        color: const Color(0xFF566777), // Light Blue color
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
