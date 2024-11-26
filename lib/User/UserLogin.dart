import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency/User/SignUp.dart';
import 'package:currency/main.dart';
import 'package:currency/models/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Userlogin extends StatefulWidget {
  const Userlogin({super.key});

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> userLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        User? user = userCredential.user;
        if (user != null) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('Email', isEqualTo: emailController.text.trim())
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot userDoc = querySnapshot.docs.first;
            String userId = userDoc.id;

            Map<String, dynamic>? userData =
                userDoc.data() as Map<String, dynamic>?;

            if (userData != null) {
              await SharedPreferenceshelper.saveUserName(userData["Name"]);
              await SharedPreferenceshelper.saveUserImage(
                  "https://static.vecteezy.com/system/resources/previews/026/960/765/non_2x/profile-icon-simple-flat-style-person-people-user-avatar-pictogram-message-office-business-man-concept-illustration-isolated-on-white-background-eps-10-vector.jpg");
              await SharedPreferenceshelper.saveUserId(userId);

              // Show the smooth popup dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white, // Pink
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_outline, 
                            color:Color(0xFF597CFF), size: 50),
                        const SizedBox(height: 20),
                        const Text(
                          "Login Successfully",
                          style: TextStyle(
                            color:Color(0xFF597CFF),
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyDrawer()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:Color(0xFF597CFF), // Dark Blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text("Continue"),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              throw Exception("User Data is null");
            }
          } else {
            throw Exception("User Document does not exist..");
          }
        } else {
          throw Exception("User is null");
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'invalid-email') {
          errorMessage = "No User found for that Email";
        } else if (e.code == "wrong-password") {
          errorMessage = "Wrong Password provided by User";
        } else {
          errorMessage = "An unexpected error occurred: ${e.message}";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFF566777), // Dark Blue
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFF566777), // Dark Blue
          content: Text(
            "Failed to fetch user data: ${e.toString()}",
            style: const TextStyle(fontSize: 20.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Colors.white, // Light Pink
              Colors.white, // Pink
              Color(0xFF95a7b1), // Light Blue
            Color(0xFF597CFF) // Dark Blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome Back!',
                    key: Key('welcomeText'),
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: GoogleFonts.libreCaslonText().fontFamily,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xFF597CFF), Color(0xFF597CFF), Color(0xFF597CFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),

                  Text(
                    'Log in Here...',
                    key: Key('loginText'),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.libreCaslonText().fontFamily,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [Color(0xFF597CFF), Color(0xFF597CFF),Color(0xFF597CFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            labelStyle: TextStyle(color:Colors.white), // Pink
                            hintStyle: TextStyle(color:    Colors.white), // Pink
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color:     Color(0xFF597CFF)), // Pink
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:    Color(0xFF597CFF)), // Pink
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.3),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            labelStyle: const TextStyle(color:     Colors.white), // Pink
                            hintStyle: const TextStyle(color: Colors.white), // Pink
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color:    Color(0xFF597CFF)), // Pink
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color:    Color(0xFF597CFF)), // Pink
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.3),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: () => userLogin(context),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF597CFF), // Dark Blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(fontSize: 16, color:Colors.white), // Pink
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
