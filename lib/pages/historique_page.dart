import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';

class HistoriquePage extends StatelessWidget {
  const HistoriquePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Historique'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: AppCouleurs.texteSecond),
            SizedBox(height: 16),
            Text(
              'Aucun triage effectué',
              style: TextStyle(
                fontSize: 18,
                color: AppCouleurs.texteSecond,
              ),
            ),
          ],
        ),
      ),
    );
  }
}