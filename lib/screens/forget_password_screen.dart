import 'package:bidayah/Widgets/CustomTextField.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
        "We have sent you a reset password link to your email.",
      );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const SizedBox(height:100),
              _buildHeaderImage(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 10),
              _buildSubtitle(),
              const SizedBox(height: 30),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildResetButton(),
              const SizedBox(height: 10),
              _buildBackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Image.asset(
      'assets/Forget Password.png',
      height: 250,
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Oh! Forgot Your Password?",
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 18, 49, 97),
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      "Don't worry! Enter your email and we'll help you reset it.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      label: 'Email',
      hintText: 'Enter your Email',
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
    );
  }

  Widget _buildResetButton() {
    return SizedBox(
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
    );
  }

  Widget _buildBackButton() {
    return TextButton(
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
    );
  }
}