import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Totality - Track your budget with ease'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Username field
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Log in (placeholder)
                OutlinedButton(
                  onPressed: () {
                    // Log in action
                  },
                  child: const Text('Log In'),
                ),
                const SizedBox(height: 12),

                // Sign up
                OutlinedButton(
                  onPressed: () {
                    // Sign up action
                  },
                  child: const Text('Sign Up'),
                ),

                const SizedBox(height: 40),

                // Continue without login
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Continue without login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
