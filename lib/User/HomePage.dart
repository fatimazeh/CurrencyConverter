import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
    // No need to load user data anymore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
               Image.asset(
              '../lib/images/Home_Banner.gif',
              fit: BoxFit.cover,
            ),
            // Removed User Information Row
            // Rest of your content
                      const SizedBox(height: 20.0),
            Image.asset(
              '../lib/images/Dynamic_Banner.gif',
              fit: BoxFit.cover,
            ),
       
      
            const SizedBox(height: 10.0),
            // Placeholder for the ContactForm widget
            // const ContactForm(), // Uncomment and adjust as needed
          ],
        ),
      ),
    );
  }
}
