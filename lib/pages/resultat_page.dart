import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/model/triage_result.dart';
import 'package:triage_ai/services/auth_service.dart';
import 'package:triage_ai/services/historique_service.dart';

class ResultatPage extends StatefulWidget {
  final TriageResult resultat;
  const ResultatPage({super.key, required this.resultat});

  @override
  State<ResultatPage> createState() => _ResultatPageState();
}

class _ResultatPageState extends State<ResultatPage> {
  @override
  void initState() {
    super.initState();
    _sauvegarderHistorique();
  }

  Future<void> _sauvegarderHistorique() async {
    final emailUser = await AuthService.email;
    await HistoriqueService.sauvegarder(
      resultat: widget.resultat,
      email: emailUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    final estUrgence = widget.resultat.niveau == NiveauUrgence.urgence;

    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Résultat'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: estUrgence
                    ? AppCouleurs.urgence.withOpacity(0.1)
                    : AppCouleurs.teleconsult.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                estUrgence
                    ? Icons.local_hospital
                    : Icons.video_call_outlined,
                size: 52,
                color: estUrgence
                    ? AppCouleurs.urgence
                    : AppCouleurs.teleconsult,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              estUrgence ? 'Urgences recommandées' : 'Téléconsultation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: estUrgence
                    ? AppCouleurs.urgence
                    : AppCouleurs.teleconsult,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppCouleurs.bordure),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Analyse',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppCouleurs.texteSecond,
                          fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(
                    widget.resultat.message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppCouleurs.textePrincipal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(height: 24),
                  const Text('Conseil',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppCouleurs.texteSecond,
                          fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(
                    widget.resultat.conseil,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppCouleurs.textePrincipal,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(
                    context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppCouleurs.primaire,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Retour à l\'accueil',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}