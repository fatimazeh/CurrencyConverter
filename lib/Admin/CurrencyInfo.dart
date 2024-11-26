import 'package:flutter/material.dart';

class AddCurrencyPage extends StatefulWidget {
   static const String id = "AddCurrencyPage";


  const AddCurrencyPage({super.key});

  @override
  _AddCurrencyPageState createState() => _AddCurrencyPageState();
}

class _AddCurrencyPageState extends State<AddCurrencyPage> {
  final _formKey = GlobalKey<FormState>();
  String _currencyCode = '';
  double _exchangeRate = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Currency',
          style: TextStyle(
            fontFamily: 'Parisienne',
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Currency Code',
                  labelStyle: const TextStyle(
                    color: Color(0xFF387782), // Light Blue
                    fontFamily: 'LibreCaslonText',
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF1c4951)), // Dark Blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFadddd1)), // Lightest Blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a currency code';
                  }
                  return null;
                },
                onSaved: (value) {
                  _currencyCode = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Exchange Rate',
                  labelStyle: const TextStyle(
                    color: Color(0xFF387782), // Light Blue
                    fontFamily: 'LibreCaslonText',
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF1c4951)), // Dark Blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFadddd1)), // Lightest Blue
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an exchange rate';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _exchangeRate = double.parse(value!);
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the data to the database or use it as needed
                    _saveCurrencyData(_currencyCode, _exchangeRate);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Currency added successfully!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1c4951), // Dark Blue
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add Currency',
                  style: TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCurrencyData(String currencyCode, double exchangeRate) {
    // Here you would typically save the data to a database or a backend service
    print('Currency Code: $currencyCode, Exchange Rate: $exchangeRate');
  }
}
