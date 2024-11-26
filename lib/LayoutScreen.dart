
import 'package:currency/Admin/AdminLogin.dart';
import 'package:currency/SplashScreen.dart';
import 'package:currency/main.dart';
import 'package:flutter/material.dart';



class Layoutscreen extends StatelessWidget {
  const Layoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return const AdminLogin(); //Adminlogin();
      } else {
        return const SplashScreen();
      }
    });
  }
}
