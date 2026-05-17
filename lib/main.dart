import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/pages/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TriageAIApp());
}

class TriageAIApp extends StatelessWidget {
  const TriageAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriageAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppCouleurs.primaire,
        ),
        scaffoldBackgroundColor: AppCouleurs.fond,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}