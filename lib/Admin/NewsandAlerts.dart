import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsAndArticlesPage extends StatefulWidget {
  static const String id = "NewsAndArticlesPage";
  const NewsAndArticlesPage({Key? key}) : super(key: key);

  @override
  _NewsAndArticlesPageState createState() => _NewsAndArticlesPageState();
}

class _NewsAndArticlesPageState extends State<NewsAndArticlesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _submitArticle() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get Firestore instance
        final firestore = FirebaseFirestore.instance;

        // Add article to Firestore
        await firestore.collection('news_and_articles').add({
          'title': _titleController.text.trim(),
          'content': _contentController.text.trim(),
          'timestamp': Timestamp.now(),
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Article submitted successfully!',
              style: GoogleFonts.libreCaslonText(color: const Color(0xFFF4EBE6)), // Light Pink
            ),
            backgroundColor: const Color(0xFF597CFF), // Blue
          ),
        );

        // Clear form fields
        _titleController.clear();
        _contentController.clear();
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit article: $e',
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
          'Submit News & Articles',
          style: GoogleFonts.libreCaslonText(color: Colors.white), // Light Pink
        ),
   
        backgroundColor: const Color(0xFF597CFF), // Blue
        elevation: 0, // Remove shadow
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Colors.white, Colors.white,Color(0xFF597CFF),], // Gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share Your Insights',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF597CFF), // Dark Blue
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Use this form to submit news articles or updates. The content will be stored in the database and can be reviewed by users.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Light Brown
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
                            TextFormField(
                              controller: _titleController,
                              style: GoogleFonts.libreCaslonText(color: Colors.black), // Input text color
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.title, color: Color(0xFF597CFF)), // Blue
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _contentController,
                              maxLines: 10,
                              style: GoogleFonts.libreCaslonText(color: Colors.black), // Input text color
                              decoration: InputDecoration(
                                labelText: 'Content',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.article, color: Color(0xFF597CFF)), // Blue
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the content';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            Center(
                              child: ElevatedButton(
                                onPressed: _submitArticle,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF597CFF), // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Text(
                                  'Submit Article',
                                  style: GoogleFonts.libreCaslonText(
                                    fontSize: 18.0,
                                    color: Colors.white, // Light Pink
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
