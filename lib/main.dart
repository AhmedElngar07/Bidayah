import 'package:bidayah/Cubits/Skill_cubit.dart';
import 'package:bidayah/Screens/profile_screen.dart';
import 'package:bidayah/Services/firebase_Services.dart';
import 'package:bidayah/Services/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Ensure this is set
  );
  runApp(const MyApp());
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat', useMaterial3: true),
        home: ProfileScreen(), // Set the initial screen
      ),
    );
  }
}
