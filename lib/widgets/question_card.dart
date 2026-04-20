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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppCouleurs.carteQuestion,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppCouleurs.bordure),
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
          // Indicateur de progression
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $numeroQuestion / $totalQuestions',
                style: const TextStyle(
                  color: AppCouleurs.texteSecond,
                  fontSize: 13,
                ),
              ),
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

          const SizedBox(height: 16),

          // Texte de la question
          Text(
            question.texte,
            style: const TextStyle(
              fontSize: 18,
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