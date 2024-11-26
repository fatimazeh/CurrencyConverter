import 'package:currency/User/UserLogin.dart';
import 'package:currency/models/data-file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, mail, password, confirmPassword;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> registration() async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Passwords do not match.',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ));
      return;
    }

    if (name != null && mail != null && password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String Id = randomAlphaNumeric(10);

        // Creating user info map
        Map<String, dynamic> userInfoMap = {
          "Id": Id,
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Image":
              "https://static.vecteezy.com/system/resources/previews/026/960/765/non_2x/profile-icon-simple-flat-style-person-people-user-avatar-pictogram-message-office-business-man-concept-illustration-isolated-on-white-background-eps-10-vector.jpg"
        };

        // Inserting user information into Firestore under the "users" collection
        await FirebaseFirestore.instance.collection('users').doc(Id).set(userInfoMap);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFF597CFF), // Dark Blue
          content: Text(
            "Registered Successfully",
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.pacifico().fontFamily,
            ),
          ),
        ));

        // Navigate to User Login screen after successful registration
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Userlogin()));
      } on FirebaseException catch (e) {
        String errorMessage = e.code == "weak-password"
            ? "Weak Password. Please use a stronger password."
            : e.code == "email-already-in-use"
                ? "Email already exists."
                : "An unexpected error occurred: ${e.message}";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ));
      }
    }
  }

  InputDecoration buildInputDecoration(String labelText, String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black), // Light Blue
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black), // Dark Blue
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black), // Pink
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF597CFF)), // Pink
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF597CFF)), // Pink
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      fillColor: Colors.white, // Light Brown
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white, // Pink
              Color(0xFFf4ebe6), // Light Pink
              Color(0xFF597CFF), // Light Blue
              Color(0xFF597CFF), // Dark Blue
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40.0),

                  // Heading Text with Gradient
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.libreCaslonText().fontFamily,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Name TextField
                  TextFormField(
                    controller: namecontroller,
                    decoration: buildInputDecoration('Name', 'Enter your name'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins', // Stylish font family
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Email TextField
                  TextFormField(
                    controller: mailcontroller,
                    decoration: buildInputDecoration('Email', 'Enter your email'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins', // Stylish font family
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Password TextField
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: buildInputDecoration('Password', 'Enter your password'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins', // Stylish font family
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Confirm Password TextField
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: buildInputDecoration(
                        'Confirm Password', 'Confirm your password'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins', // Stylish font family
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordcontroller.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          mail = mailcontroller.text;
                          name = namecontroller.text;
                          password = passwordcontroller.text;
                          confirmPassword = confirmPasswordController.text;
                        });
                        registration();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFf4ebe6), // Light Pink
                      backgroundColor: Color(0xFF597CFF), // Dark Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins', // Stylish font family
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Already have an account text
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Userlogin()),
                      );
                    },
                    child: const Center(
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins', // Stylish font family
                          fontSize: 16.0,
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
    );
  }
}
