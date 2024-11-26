import 'package:flutter/material.dart';
import 'package:currency/main.dart';
import 'package:currency/models/data-file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Frequently Asked Questions',
          style: GoogleFonts.libreCaslonText(
            color: Colors.white, // White text color
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF597CFF), // Dark Blue background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // White back icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // Light Pink
              Colors.white,
              Colors.white,
              Color(0xFF597CFF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 3.0),
                child: Image.asset(
                  '../lib/images/Dynamic_Banner.gif', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    },
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.libreCaslonText(
                        color: const Color(0xFFF4EBE6), // Light Pink text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF597CFF), // Dark Blue background
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Frequently Asked Questions (FAQ)',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black text color
                ),
              ),
              const SizedBox(height: 24.0),
              const FAQSection(),
              const SizedBox(height: 40.0),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Colors.white, // Light Blue
                      Color(0xFF597CFF), // Dark Blue
                    ],
                  ),
                ),
                child: Text(
                  'Contact Us',
                  style: GoogleFonts.libreCaslonText(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black text color
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const ContactForm(), // Inserting the ContactForm widget here
            ],
          ),
        ),
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FAQItem(
          question: 'How do I convert currencies?',
          answer: 'To convert currencies, use the CurrenSee app to select the currency pair, enter the amount, and the conversion rate will be displayed.',
        ),
        FAQItem(
          question: 'Can I see historical exchange rates?',
          answer: 'Yes, CurrenSee provides historical data on exchange rates. Navigate to the Exchange Rate Details page to view trends over time.',
        ),
        FAQItem(
          question: 'How do I set up rate alerts?',
          answer: 'Rate alerts can be set up within the app. Go to the settings page and configure the alert conditions for your desired currency pairs.',
        ),
        FAQItem(
          question: 'Is my personal data secure?',
          answer: 'Yes, CurrenSee uses industry-standard encryption to ensure that your personal data is kept safe and secure.',
        ),
        // Add more FAQs as needed
      ],
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: GoogleFonts.libreCaslonText(
          fontWeight: FontWeight.bold,
          color: Colors.black, // Black text color
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answer,
            style: GoogleFonts.libreCaslonText(
              color: Colors.black, // Black text color
            ),
          ),
        ),
      ],
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Black border
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Black border
              ),
            ),
            style: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Black border
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Black border
              ),
            ),
            style: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
              hintText: 'Enter your message',
              hintStyle: GoogleFonts.libreCaslonText(color: Colors.black.withOpacity(0.7)), // Black hint color
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Black border
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Black border
              ),
            ),
            style: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> usercontactMap = {
                  "Id": id,
                  "Name": _nameController.text,
                  "Email": _emailController.text,
                  "Message": _messageController.text,
                };

                try {
                  await DatabaseMethods()
                      .ContactDetails(usercontactMap, id)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Message sent!',
                          style: GoogleFonts.libreCaslonText(color: Colors.black), // Black text color
                        ),
                        backgroundColor: const Color(0xFF597CFF), // Dark Blue background color
                      ),
                    );

                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  });
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "Failed to send message. Please try again.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(0xFF597CFF), // Dark Blue background color
                    textColor: Colors.black, // Black text color
                    fontSize: 16.0,
                  );
                  print('Error sending message: $e');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFF4EBE6), // Light Pink text color
              backgroundColor: const Color(0xFF597CFF), // Dark Blue background color
            ),
            child: Center(
              child: Text(
                'Submit',
                style: GoogleFonts.libreCaslonText(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 30.0), // Added space below the submit button
        ],
      ),
    );
  }
}
