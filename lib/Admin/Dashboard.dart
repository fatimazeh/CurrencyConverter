import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatelessWidget {
  static const String id = "AdminDashboard";

  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a Container to apply the gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Dashboard Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust color for visibility
                  fontFamily: 'Montserrat', // Use Montserrat font
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to the Admin Dashboard. Here you can manage all the aspects of the currency conversion app, including adding new currencies, updating exchange rates, and viewing system statistics.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white, // Adjust color for visibility
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Use the sidebar to navigate through different sections. For assistance or more information, refer to the documentation or contact support.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white, // Adjust color for visibility
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
