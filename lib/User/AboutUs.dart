import 'package:currency/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.libreCaslonText(
            color: Colors.white, // White text color
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF597CFF), // Blue background

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
             Colors.white, // Blue
              Color(0xFF597CFF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Picture widget (not a full background)
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 3.0),
                child: Image.asset(
                  '../lib/images/missionbanner.gif', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyApp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF597CFF), // Blue background
                    ),
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.libreCaslonText(
                        color: Colors.white, // White text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Welcome to CurrenSee, your trusted partner in navigating the '
                'complex world of currency exchange. Whether you are an individual '
                'traveler, a business owner, or someone who frequently deals with '
                'multiple currencies, CurrenSee is designed to meet your financial '
                'needs with precision and ease.',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 16.0,
                  color: Colors.black, // White text color
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'CurrenSee offers a comprehensive suite of features to help you '
                'stay on top of currency trends and make informed financial '
                'decisions. Our platform provides:',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 16.0,
                  color: Colors.black, // White text color
                ),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(height: 40.0),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0), // Adjust padding as needed
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white, // Pink
                      Color(0xFF597CFF), // Blue
                    ],
                  ),
                ),
                child: Text(
                  'Founded by a team of finance and technology enthusiasts, CurrenSee was created to address the growing need for a reliable and user-friendly currency conversion solution. Our team combines expertise in financial services, software development, and user experience design to deliver an app that meets the diverse needs of our users.',
                  style: GoogleFonts.libreCaslonText(
                    fontSize: 19,
                    color: Colors.black, // White text color
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              // Inserting the ContactForm widget here
              // Ensure to import and use the ContactForm widget as needed
            ],
          ),
        ),
      ),
    );
  }
}
