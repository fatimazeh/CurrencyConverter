import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get Firestore instance
        final firestore = FirebaseFirestore.instance;

        // Add feedback to Firestore
        await firestore.collection('feedback').add({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'feedback': _feedbackController.text.trim(),
          'timestamp': Timestamp.now(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Feedback submitted successfully!',
              style: GoogleFonts.libreCaslonText(color: const Color(0xFFF4EBE6)), // Light Pink
            ),
            backgroundColor: const Color(0xFF597CFF), // Dark Blue
          ),
        );

        // Clear form fields
        _nameController.clear();
        _emailController.clear();
        _feedbackController.clear();
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit feedback: $e',
              style: GoogleFonts.libreCaslonText(color: const Color(0xFFF4EBE6)), // Light Pink
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: GoogleFonts.libreCaslonText(
            color: Colors.white, // White text color
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF597CFF), // Dark Blue
      ),
      body: Column(
        
        children: [
          
          // Image outside the container
      
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF597CFF), // Dark Blue
                    Color(0xFFFFE1DE), // Light Pink
                    Colors.white, // White
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'We Value Your Feedback',
                                style: GoogleFonts.libreCaslonText(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF597CFF), // Dark Blue
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: _nameController,
                                style: GoogleFonts.libreCaslonText(color: Colors.black), // Black input text color
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person, color: Color(0xFF597CFF)), // Dark Blue
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: _emailController,
                                style: GoogleFonts.libreCaslonText(color: Colors.black), // Black input text color
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email, color: Color(0xFF597CFF)), // Dark Blue
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  // Basic email validation
                                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: _feedbackController,
                                maxLines: 5,
                                style: GoogleFonts.libreCaslonText(color: Colors.black), // Black input text color
                                decoration: const InputDecoration(
                                  labelText: 'Feedback',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.feedback, color: Color(0xFF597CFF)), // Dark Blue
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your feedback';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20.0),
                              Center(
                                child: ElevatedButton(
                                  onPressed: _submitFeedback,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF597CFF), // Dark Blue
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Submit Feedback',
                                    style: GoogleFonts.libreCaslonText(
                                      fontSize: 18.0,
                                      color: const Color(0xFFF4EBE6), // Light Pink
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
