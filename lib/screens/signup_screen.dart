import 'package:bidayah/Widgets/CustomTextField.dart';
import 'package:bidayah/blocs/auth/auth_bloc.dart';
import 'package:bidayah/blocs/auth/auth_event.dart';
import 'package:bidayah/blocs/auth/auth_state.dart';
import 'package:bidayah/screens/login_screen.dart';
import 'package:bidayah/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool agreePersonalData = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color.fromARGB(232, 7, 22, 189), Color(0xFF000000)],
              ),
            ),
          ),
          SafeArea(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  // Navigate to login screen on successful signup
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else if (state is AuthFailure) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: Column(
                children: [
                  const Expanded(flex: 1, child: SizedBox(height: 10)),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: _buildSignUpForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formSignupKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create your account',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
                
              ),
            ),
            const SizedBox(height: 40.0),
            // Full Name field
            CustomTextField(
              label: 'Full Name',
              hintText: 'Enter Full Name',
              controller: _fullNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 25.0),
            // Email field
            CustomTextField(
              label: 'Email',
              hintText: 'Enter Email',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              },
            ),
            const SizedBox(height: 25.0),
            // Password field
            CustomTextField(
              label: 'Password',
              hintText: 'Enter Password',
              isPassword: true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            ),
            const SizedBox(height: 25.0),
            
            // Sign Up button
            _buildSignUpButton(),
            const SizedBox(height: 30.0),
            _buildDividerWithText('Sign up with'),
            const SizedBox(height: 30.0),
            // Social sign up row (empty for now)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [],
            ),
            const SizedBox(height: 25.0),
            _buildSignInRow(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomButton(
          text: state is AuthLoading ? 'Signing up...' : 'Sign up',
          onPressed: () {
            if (state is! AuthLoading) {
              _handleSignUp(context);
            }
          },
          
          textColor: Colors.white,
        );
      },
    );
  }

  void _handleSignUp(BuildContext context) {
    // Validate form
    if (_formSignupKey.currentState!.validate() && agreePersonalData) {
      // Dispatch signup event
      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              fullName: _fullNameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    } else if (!agreePersonalData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the processing of personal data'),
        ),
      );
    }
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black45),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.7,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.black45),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: Text(
            'Sign in',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ),
      ],
    );
  }
}