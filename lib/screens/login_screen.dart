import 'package:bidayah/screens/signup_screen.dart';
import 'package:bidayah/services/auth_service.dart';
import 'package:bidayah/widgets/button.dart';
import 'package:bidayah/widgets/passwordtextfield.dart';
import 'package:bidayah/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:bidayah/widgets/custom_scaffold.dart';
import 'package:bidayah/widgets/theme.dart';


final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    // Use CustomTextField for email
                    CustomTextField(
                      label: 'Email',
                      hintText: 'm@example.com',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Dimmed text color
                          fontSize: 14.0, // Smaller text size
                        ),
                        hintText: 'Enter your Email',
                        
                        hintStyle: const TextStyle(color: Colors.black26),
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
                    const SizedBox(height: 25.0),
                    // Use CustomPasswordTextField for password
                    CustomPasswordTextField(
                      label: 'Password',
                      hintText: 'Enter your password',
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.black45, // Dimmed text color
                          fontSize: 14.0, // Smaller text size
                        ),
                        hintText: '..........',
                        hintStyle: const TextStyle(color: Colors.black26),
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
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {},
                          activeColor: lightColorScheme.primary,
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(color: Colors.black45),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Navigate to forget password screen
                          },
                          child: Text(
                            'Forget password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    // Use CustomButton for Sign In
                    CustomButton(
                      text: 'Log in',
                      onPressed: () async{
                        await AuthService().login(
                        email: _emailController.text,
                         password: _passwordController.text,
                        context: context
                        
                         );


                        },
                      
                      backgroundColor:
                          lightColorScheme.primary, // Your theme color
                      textColor: Colors.white, // Ensure white text
                    ),

                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          child: Text(
                            'Sign in with',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account? ',
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
                              color: lightColorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
