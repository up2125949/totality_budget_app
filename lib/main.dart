import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TotalityApp());
}

class TotalityApp extends StatelessWidget {
  const TotalityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Totality Budget App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Start from the login screen
    );
  }
}
