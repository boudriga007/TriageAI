import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';

class ReponseBtn extends StatelessWidget {
  final String texte;
  final bool estSelectionne;
  final VoidCallback onTap;

  const ReponseBtn({
    super.key,
    required this.texte,
    required this.estSelectionne,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: estSelectionne
              ? AppCouleurs.primaire
              : AppCouleurs.carteQuestion,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: estSelectionne
                ? AppCouleurs.primaire
                : AppCouleurs.bordure,
            width: estSelectionne ? 2 : 1,
          ),
          boxShadow: estSelectionne
              ? [
                  BoxShadow(
                    color: AppCouleurs.primaire.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              estSelectionne
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: estSelectionne
                  ? Colors.white
                  : AppCouleurs.texteSecond,
              size: 22,
            ),
            const SizedBox(width: 14),
            Text(
              texte,
              style: TextStyle(
                fontSize: 16,
                fontWeight: estSelectionne
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: estSelectionne
                    ? Colors.white
                    : AppCouleurs.textePrincipal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}