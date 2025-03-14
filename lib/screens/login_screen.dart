import 'package:bidayah/Widgets/CustomTextField.dart';
import 'package:bidayah/screens/forget_password_screen.dart';
import 'package:bidayah/blocs/auth/auth_bloc.dart';
import 'package:bidayah/blocs/auth/auth_event.dart';
import 'package:bidayah/blocs/auth/auth_state.dart';
import 'package:bidayah/screens/signup_screen.dart';
import 'package:bidayah/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
                  // Navigate to home screen on successful authentication
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                      child: _buildLoginForm(),
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

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login to your account',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              
            ),
          ),
          const SizedBox(height: 40.0),
          // Email field
          CustomTextField(
            label: 'Email',
            hintText: 'Enter your Email',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 25.0),
          // Password field
          CustomTextField(
            label: 'Password',
            hintText: 'Enter your Password', 
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 25.0),
          _buildForgetPasswordRow(),
          const SizedBox(height: 25.0),
          _buildLoginButton(),
          const SizedBox(height: 30.0),
          _buildDividerWithText('Sign in with'),
          const SizedBox(height: 30.0),
          // Social sign in row (empty for now)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [],
          ),
          const SizedBox(height: 25.0),
          _buildSignUpRow(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildForgetPasswordRow() {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgetPasswordScreen(),
              ),
            );
          },
          child: Text(
            'Forget password?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return CustomButton(
          text: state is AuthLoading ? 'Logging in...' : 'Log in',
          onPressed: () {
            if (state is! AuthLoading) {
              _handleLogin(context);
            }
          },
          
          textColor: Colors.white,
        );
      },
    );
  }

  void _handleLogin(BuildContext context) {
    // Validate input
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    
    // Dispatch login event
    context.read<AuthBloc>().add(
          AuthLoginRequested(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          ),
        );
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

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? ',
          style: TextStyle(color: Colors.black45),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ),
      ],
    );
  }
}
