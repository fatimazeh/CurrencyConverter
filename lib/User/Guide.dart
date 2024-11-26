import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyInfoPage extends StatefulWidget {
  @override
  _CurrencyInfoPageState createState() => _CurrencyInfoPageState();
}

class _CurrencyInfoPageState extends State<CurrencyInfoPage> {
  final List<Map<String, String>> _currencies = [
    {'Code': 'USD', 'Name': 'United States Dollar', 'Symbol': '\Dollar', 'Rate': '1.092939'},
    {'Code': 'EUR', 'Name': 'Euro', 'Symbol': '€', 'Rate': '0.85'},
    {'Code': 'GBP', 'Name': 'British Pound', 'Symbol': '£', 'Rate': '0.75'},
    {'Code': 'JPY', 'Name': 'Japanese Yen', 'Symbol': '¥', 'Rate': '110.50'},
    {'Code': 'AUD', 'Name': 'Australian Dollar', 'Symbol': 'ADollar', 'Rate': '1.60'},
    {'Code': 'AED', 'Name': 'United Arab Emirates Dirham', 'Symbol': 'د.إ', 'Rate': '4.00'},
    {'Code': 'AFN', 'Name': 'Afghan Afghani', 'Symbol': '؋', 'Rate': '91.00'},
    {'Code': 'ALL', 'Name': 'Albanian Lek', 'Symbol': 'L', 'Rate': '117.00'},
    {'Code': 'AMD', 'Name': 'Armenian Dram', 'Symbol': '֏', 'Rate': '510.00'},
    {'Code': 'ANG', 'Name': 'Netherlands Antillean Guilder', 'Symbol': 'ƒ', 'Rate': '1.92'},
    {'Code': 'AOA', 'Name': 'Angolan Kwanza', 'Symbol': 'Kz', 'Rate': '825.00'},
    {'Code': 'ARS', 'Name': 'Argentine Peso', 'Symbol': 'Dollar', 'Rate': '371.00'},
    {'Code': 'BHD', 'Name': 'Bahraini Dinar', 'Symbol': '.د.ب', 'Rate': '0.41'},
    {'Code': 'INR', 'Name': 'Indian Rupee', 'Symbol': '₹', 'Rate': '83.00'},
    {'Code': 'BRL', 'Name': 'Brazilian Real', 'Symbol': 'RDollar', 'Rate': '5.55'},
    {'Code': 'BGN', 'Name': 'Bulgarian Lev', 'Symbol': 'лв', 'Rate': '1.95'},
    {'Code': 'CAD', 'Name': 'Canadian Dollar', 'Symbol': 'CDollar', 'Rate': '1.45'},
    {'Code': 'CLP', 'Name': 'Chilean Peso', 'Symbol': 'Dollar', 'Rate': '859.00'},
    {'Code': 'COP', 'Name': 'Colombian Peso', 'Symbol': 'Dollar', 'Rate': '4595.00'},
    {'Code': 'CZK', 'Name': 'Czech Koruna', 'Symbol': 'Kč', 'Rate': '23.00'},
    {'Code': 'DKK', 'Name': 'Danish Krone', 'Symbol': 'kr', 'Rate': '7.43'},
    {'Code': 'HKD', 'Name': 'Hong Kong Dollar', 'Symbol': 'HKDollar', 'Rate': '8.55'},
    {'Code': 'LYD', 'Name': 'Libyan Dinar', 'Symbol': 'ل.د', 'Rate': '5.63'},
    {'Code': 'MYR', 'Name': 'Malaysian Ringgit', 'Symbol': 'RM', 'Rate': '4.79'},
    {'Code': 'MUR', 'Name': 'Mauritian Rupee', 'Symbol': '₨', 'Rate': '44.00'},
    {'Code': 'MXN', 'Name': 'Mexican Peso', 'Symbol': 'Dollar', 'Rate': '18.00'},
    {'Code': 'NPR', 'Name': 'Nepalese Rupee', 'Symbol': '₨', 'Rate': '133.00'},
    {'Code': 'NZD', 'Name': 'New Zealand Dollar', 'Symbol': 'NZDollar', 'Rate': '1.67'},
    {'Code': 'NOK', 'Name': 'Norwegian Krone', 'Symbol': 'kr', 'Rate': '10.52'},
    {'Code': 'OMR', 'Name': 'Omani Rial', 'Symbol': 'ر.ع.', 'Rate': '0.42'},
    {'Code': 'PKR', 'Name': 'Pakistani Rupee', 'Symbol': '₨', 'Rate': '284.00'},
    {'Code': 'PHP', 'Name': 'Philippine Peso', 'Symbol': '₱', 'Rate': '55.00'},
    {'Code': 'PLN', 'Name': 'Polish Zloty', 'Symbol': 'zł', 'Rate': '4.57'},
    {'Code': 'QAR', 'Name': 'Qatari Rial', 'Symbol': 'ر.ق', 'Rate': '3.98'},
    {'Code': 'SAR', 'Name': 'Saudi Riyal', 'Symbol': 'ر.س', 'Rate': '4.10'},
    {'Code': 'SGD', 'Name': 'Singapore Dollar', 'Symbol': 'SDollar', 'Rate': '1.48'},
    {'Code': 'ZAR', 'Name': 'South African Rand', 'Symbol': 'R', 'Rate': '18.00'},
    {'Code': 'KRW', 'Name': 'South Korean Won', 'Symbol': '₩', 'Rate': '1417.00'},
    {'Code': 'LKR', 'Name': 'Sri Lankan Rupee', 'Symbol': '₨', 'Rate': '256.00'},
    {'Code': 'SEK', 'Name': 'Swedish Krona', 'Symbol': 'kr', 'Rate': '11.48'},
    {'Code': 'CHF', 'Name': 'Swiss Franc', 'Symbol': 'CHF', 'Rate': '0.94'},
    {'Code': 'TWD', 'Name': 'New Taiwan Dollar', 'Symbol': 'NTDollar', 'Rate': '32.00'},
    {'Code': 'THB', 'Name': 'Thai Baht', 'Symbol': '฿', 'Rate': '37.00'},
    {'Code': 'TTD', 'Name': 'Trinidad and Tobago Dollar', 'Symbol': 'TTDollar', 'Rate': '7.37'},
    {'Code': 'TRY', 'Name': 'Turkish Lira', 'Symbol': '₺', 'Rate': '20.00'},
    {'Code': 'USD', 'Name': 'United States Dollar', 'Symbol': 'Dollar', 'Rate': '1.00'},
    {'Code': 'VEF', 'Name': 'Venezuelan Bolívar', 'Symbol': 'Bs', 'Rate': '24.00'},
  ];

  late List<Map<String, String>> _filteredCurrencies;

  @override
  void initState() {
    super.initState();
    _filteredCurrencies = _currencies;
  }

  void _filterCurrencies(String query) {
    final filtered = _currencies.where((currency) {
      final code = currency['Code']?.toLowerCase();
      final name = currency['Name']?.toLowerCase();
      final searchQuery = query.toLowerCase();
      return code!.contains(searchQuery) || name!.contains(searchQuery);
    }).toList();

    setState(() {
      _filteredCurrencies = filtered;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
  title: Text(
    'Currency Information',
    style: GoogleFonts.libreCaslonText(color:  Colors.white), // Light Pink
  ),
  backgroundColor: const Color(0xFF597CFF), // Dark Blue
  iconTheme: IconThemeData(color: Colors.white), // Set back button color to white
),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
           Colors.white, // Blue
           Colors.white, // Pink
          Color(0xFF597CFF),      // White
          ],
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: _filterCurrencies,
            decoration: InputDecoration(
              labelText: 'Search Currency',
              labelStyle: GoogleFonts.libreCaslonText(color:            Colors.white,), // Light Blue
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search, color:           Colors.white,), // Dark Blue
            ),
            style: GoogleFonts.libreCaslonText(color: Colors.black), // Input text color
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = _filteredCurrencies[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  color: Colors.white, // Light Brown
                  child: ListTile(
                    title: Text(
                      '${currency['Name']} (${currency['Code']})',
                      style: GoogleFonts.libreCaslonText(color: const Color(0xFF001F3D)), // Dark Blue
                    ),
                    subtitle: Text(
                      'Symbol: ${currency['Symbol']}\nRate: ${currency['Rate']}',
                      style: GoogleFonts.libreCaslonText(color: const Color(0xFF566777)), // Light Blue
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

void main() => runApp(MaterialApp(home: CurrencyInfoPage()));
