import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/pages/login_page.dart';

void main() {
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