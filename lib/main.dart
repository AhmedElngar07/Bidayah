import 'package:bidayah/Cubits/Skill_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

// Firebase options
import 'firebase_options.dart';

// Screens
import 'Screens/Interest_page.dart';
import 'Screens/Skill_selection_page.dart';

// Bloc


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SkillCubit>(create: (context) => SkillCubit()), // ✅ Ensure SkillCubit is provided
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          useMaterial3: true,
        ),
        home: const SkillSelectionPage(), // ✅ Set the initial screen
      ),
    );
  }
}
