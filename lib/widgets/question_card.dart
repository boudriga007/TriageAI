import 'package:flutter/material.dart';
import 'package:triage_ai/model/question.dart';
import 'package:triage_ai/const/couleurs.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int numeroQuestion;
  final int totalQuestions;

  const QuestionCard({
    super.key,
    required this.question,
    required this.numeroQuestion,
    required this.totalQuestions,
  });

  // Icône selon la catégorie
  IconData _iconeCategorie(String categorie) {
    switch (categorie) {
      case 'Douleur':       return Icons.healing_outlined;
      case 'Respiratoire':  return Icons.air_outlined;
      case 'Neurologique':  return Icons.psychology_outlined;
      case 'Digestif':      return Icons.monitor_heart_outlined;
      case 'Général':       return Icons.thermostat_outlined;
      default:              return Icons.medical_services_outlined;
    }
  }

  // Couleur selon la catégorie
  Color _couleurCategorie(String categorie) {
    switch (categorie) {
      case 'Douleur':       return const Color(0xFFE53935);
      case 'Respiratoire':  return const Color(0xFF1E88E5);
      case 'Neurologique':  return const Color(0xFF8E24AA);
      case 'Digestif':      return const Color(0xFF43A047);
      case 'Général':       return const Color(0xFFFB8C00);
      default:              return AppCouleurs.primaire;
    }
  }

  @override
  Widget build(BuildContext context) {
    final couleur = _couleurCategorie(question.categorie);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppCouleurs.carteQuestion,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: couleur.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header : catégorie + critique
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge catégorie
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: couleur.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(_iconeCategorie(question.categorie),
                        color: couleur, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      question.categorie,
                      style: TextStyle(
                        color: couleur,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Badge critique
              if (question.estCritique)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppCouleurs.urgence.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: AppCouleurs.urgence, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Critique',
                        style: TextStyle(
                          color: AppCouleurs.urgence,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 8),

          // Numéro question
          Text(
            'Question $numeroQuestion / $totalQuestions',
            style: const TextStyle(
              color: AppCouleurs.texteSecond,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),

          // Texte question
          Text(
            question.texte,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppCouleurs.textePrincipal,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}