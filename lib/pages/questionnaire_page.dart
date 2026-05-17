import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/model/patient.dart';
import 'package:triage_ai/model/reponse.dart';
import 'package:triage_ai/services/auth_service.dart';
import 'package:triage_ai/services/questionnaire_logic.dart';
import 'package:triage_ai/services/triage_service.dart';
import 'package:triage_ai/widgets/question_card.dart';
import 'package:triage_ai/widgets/reponse_btn.dart';
import 'package:triage_ai/pages/resultat_page.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  late final TriageService _service;
  final _questions      = QuestionnaireLogic.getQuestions();
  int _indexCourant     = 0;
  String? _reponseSelectionnee;
  bool _enChargement    = false;
  String _prenomAffiche = '';

  @override
  void initState() {
    super.initState();
    _service = TriageService();
    _initialiserPatient();
  }

  Future<void> _initialiserPatient() async {
    final nom    = await AuthService.nomComplet;
    final age    = await AuthService.age;
    final sexe   = await AuthService.sexe;
    final prenom = await AuthService.prenom;
    _service.setPatient(Patient(
      nom:  nom,
      age:  age,
      sexe: sexe,
    ));
    setState(() => _prenomAffiche = prenom);
  }

  void _suivant() async {
    if (_reponseSelectionnee == null) return;

    _service.ajouterReponse(Reponse(
      questionId: _questions[_indexCourant].id,
      valeur: _reponseSelectionnee!,
    ));

    if (_indexCourant < _questions.length - 1) {
      setState(() {
        _indexCourant++;
        _reponseSelectionnee = null;
      });
    } else {
      setState(() => _enChargement = true);
      final resultat = await _service.calculerTriage();
      if (!mounted) return;
      setState(() => _enChargement = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultatPage(resultat: resultat),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Triage médical'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
      ),
      body: _enChargement ? _buildChargement() : _buildQuestionnaire(),
    );
  }

  Widget _buildChargement() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppCouleurs.primaire),
          SizedBox(height: 20),
          Text(
            'Analyse en cours...',
            style: TextStyle(
                fontSize: 16, color: AppCouleurs.texteSecond),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionnaire() {
    final question = _questions[_indexCourant];
    final progress = (_indexCourant + 1) / _questions.length;

    return Column(
      children: [
        // ── Header fixe ──
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Column(
            children: [
              // Bonjour patient
              Row(
                children: [
                  const Icon(Icons.waving_hand,
                      color: AppCouleurs.primaire, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Bonjour $_prenomAffiche',
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppCouleurs.texteSecond,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Barre de progression
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppCouleurs.bordure,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    AppCouleurs.primaire),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 24),

              // Carte question
              QuestionCard(
                question: question,
                numeroQuestion: _indexCourant + 1,
                totalQuestions: _questions.length,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // ── Réponses scrollables ──
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ...question.choix.map((choix) => ReponseBtn(
                      texte: choix,
                      estSelectionne: _reponseSelectionnee == choix,
                      onTap: () =>
                          setState(() => _reponseSelectionnee = choix),
                    )),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        // ── Bouton suivant fixe en bas ──
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed:
                  _reponseSelectionnee != null ? _suivant : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppCouleurs.primaire,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppCouleurs.bordure,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                _indexCourant == _questions.length - 1
                    ? 'Voir le résultat'
                    : 'Question suivante',
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}