import 'package:bidayah/blocs/auth/auth_bloc.dart';
import 'package:bidayah/Cubits/Skill_cubit.dart';
import 'package:bidayah/Screens/welcome_screen.dart';
import 'package:bidayah/services/auth_service.dart';
import 'package:bidayah/Services/firebase_Services.dart';
import 'package:bidayah/Services/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text("Firebase Init Error: ${snapshot.error}")),
            ),
          );
        }
        return const MyApp();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SkillCubit>(
          create: (context) => SkillCubit(FirebaseService()),
        ),
      ],
      child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authService: AuthService(),
          ),
        ),
        // Add other BLoCs here as needed
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
            theme: ThemeData(
            fontFamily: 'Montserrat', 
              useMaterial3: true
            ),
          // home:  HomePage(),
          home: WelcomeScreen(), // Set the initial screen
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}