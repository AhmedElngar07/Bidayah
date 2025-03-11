import 'package:bidayah/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Function to handle password reset with EasyLoading
  Future<void> resetPassword() async {
    if (_emailController.text.isEmpty) {
      EasyLoading.showError("Please enter your email!");
      return;
    }

    EasyLoading.show(status: "Sending reset email...");

    try {
      await auth.sendPasswordResetEmail(email: _emailController.text);
      EasyLoading.showSuccess(
          "We have sent you a reset password link to your email.");
      _emailController.clear();
      // Close screen after success
      Navigator.pop(context); 
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError("Failed to send reset email. ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Forget Password.png',
              height: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              "Oh! Forgot Your Password?",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 18, 49, 97),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Don't worry! Enter your email and we'll help you reset it.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Custom Email Input Field with Icon
            CustomTextField(
              label: 'Email',
              hintText: 'm@example.com',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(
                  color: Colors.black45,
                  fontSize: 14.0,
                ),
                hintText: 'Enter your Email',
                hintStyle: const TextStyle(color: Colors.black26),
                prefixIcon: const Icon(Icons.email, color: Colors.black45), // Added icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Reset Password Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 49, 97),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Back Button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.arrow_back, size: 20, color: Color.fromARGB(255, 18, 49, 97)),
                  SizedBox(width: 5),
                  Text(
                    "Back",
                    style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 18, 49, 97)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
