import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/pages/questionnaire_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              const Text(
                'TriageAI',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppCouleurs.primaire,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Évaluation intelligente de vos symptômes',
                style: TextStyle(
                  fontSize: 16,
                  color: AppCouleurs.texteSecond,
                ),
              ),

              const SizedBox(height: 40),

              // Carte principale
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppCouleurs.primaire,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.medical_services,
                        color: Colors.white, size: 40),
                    SizedBox(height: 16),
                    Text(
                      'Comment vous sentez-vous ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Répondez à quelques questions pour savoir si vous devez aller aux urgences ou opter pour une téléconsultation.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Infos rapides
              Row(
                children: [
                  _infoCard(
                    Icons.timer_outlined,
                    '2 minutes',
                    'Durée',
                  ),
                  const SizedBox(width: 16),
                  _infoCard(
                    Icons.quiz_outlined,
                    '7 questions',
                    'Questionnaire',
                  ),
                  const SizedBox(width: 16),
                  _infoCard(
                    Icons.verified_outlined,
                    'IA médicale',
                    'Analyse',
                  ),
                ],
              ),

              const Spacer(),

              // Bouton démarrer
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuestionnairePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppCouleurs.primaire,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_rounded, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Démarrer le triage',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String valeur, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppCouleurs.bordure),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppCouleurs.primaire, size: 22),
            const SizedBox(height: 6),
            Text(
              valeur,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: AppCouleurs.textePrincipal,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppCouleurs.texteSecond,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}