import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/pages/questionnaire_page.dart';
import 'package:triage_ai/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _prenom = '';

  @override
  void initState() {
    super.initState();
    _chargerPrenom();
  }

  Future<void> _chargerPrenom() async {
    final prenom = await AuthService.prenom;
    setState(() => _prenom = prenom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // ── Header ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bonjour,  $_prenom 👋',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppCouleurs.textePrincipal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Comment vous sentez-vous aujourd\'hui ?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppCouleurs.texteSecond,
                        ),
                      ),
                    ],
                  ),
                  // Logo petit
                  Image.asset(
                    'assets/img/logo.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Carte principale bleue ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppCouleurs.primaire,
                      AppCouleurs.secondaire,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppCouleurs.primaire.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'طبيبي — Triage IA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Répondez à 17 questions intelligentes pour savoir '
                      'si vous devez aller aux urgences ou opter '
                      'pour une téléconsultation.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bouton démarrer dans la carte
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuestionnairePage(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppCouleurs.primaire,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow_rounded, size: 22),
                            SizedBox(width: 8),
                            Text(
                              'Démarrer le triage',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── Statistiques rapides ──
              const Text(
                'Aperçu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppCouleurs.textePrincipal,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  _statCard(
                    Icons.timer_outlined,
                    '2 min',
                    'Durée',
                    AppCouleurs.primaire,
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    Icons.quiz_outlined,
                    '17',
                    'Questions',
                    const Color(0xFF8E24AA),
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    Icons.auto_awesome,
                    'IA',
                    'Analyse',
                    const Color(0xFFFB8C00),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Catégories couvertes ──
              const Text(
                'Symptômes analysés',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppCouleurs.textePrincipal,
                ),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.8,
                children: [
                  _categorieCard(
                      Icons.healing_outlined, 'Douleur',
                      const Color(0xFFE53935)),
                  _categorieCard(
                      Icons.air_outlined, 'Respiratoire',
                      const Color(0xFF1E88E5)),
                  _categorieCard(
                      Icons.psychology_outlined, 'Neurologique',
                      const Color(0xFF8E24AA)),
                  _categorieCard(
                      Icons.monitor_heart_outlined, 'Digestif',
                      const Color(0xFF43A047)),
                  _categorieCard(
                      Icons.thermostat_outlined, 'Général',
                      const Color(0xFFFB8C00)),
                  _categorieCard(
                      Icons.verified_outlined, 'IA médicale',
                      AppCouleurs.primaire),
                ],
              ),

              const SizedBox(height: 28),

              // ── Avertissement médical ──
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppCouleurs.urgence.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppCouleurs.urgence.withOpacity(0.2)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline,
                        color: AppCouleurs.urgence, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Cet outil est une aide à la décision et ne '
                        'remplace pas un avis médical professionnel. '
                        'En cas d\'urgence vitale, appelez le 190.',
                        style: TextStyle(
                          color: AppCouleurs.urgence,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(
      IconData icon, String valeur, String label, Color couleur) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppCouleurs.bordure),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: couleur.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: couleur, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              valeur,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: couleur,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppCouleurs.texteSecond,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categorieCard(IconData icon, String label, Color couleur) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: couleur.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: couleur.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: couleur, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: couleur,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}