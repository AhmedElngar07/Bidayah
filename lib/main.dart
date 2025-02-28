import 'package:bidayah/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:bidayah/widgets/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bidayah',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: lightColorScheme,
        useMaterial3: true,
        // Add other theme properties as needed
      ),
      initialRoute: '/', // Start with the welcome screen
      routes: {
        '/': (context) => const WelcomeScreen(),
        //'/login': (context) => const SignInScreen(),
        // '/signup': (context) => const SignUpScreen(),
        //'/home': (context) => const HomeScreen(), // Your main app screen
      },
    );
  }
}
