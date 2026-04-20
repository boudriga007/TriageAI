import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/services/auth_service.dart';
import 'package:triage_ai/pages/login_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            CircleAvatar(
              radius: 48,
              backgroundColor: AppCouleurs.primaire,
              child: Text(
                AuthService.prenom.isNotEmpty
                    ? AuthService.prenom[0].toUpperCase()
                    : 'P',
                style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              AuthService.nomComplet,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppCouleurs.textePrincipal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AuthService.email,
              style: const TextStyle(
                  color: AppCouleurs.texteSecond, fontSize: 14),
            ),

            const SizedBox(height: 32),

            // Infos
            _infoTile(Icons.cake_outlined,
                'Âge', '${AuthService.age} ans'),
            _infoTile(Icons.person_outline,
                'Sexe',
                AuthService.sexe == 'male' ? 'Homme' : 'Femme'),
            _infoTile(Icons.email_outlined,
                'Email', AuthService.email),

            const Spacer(),

            // Déconnexion
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  AuthService.deconnecter();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: AppCouleurs.urgence),
                label: const Text('Se déconnecter',
                    style: TextStyle(
                        color: AppCouleurs.urgence,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppCouleurs.urgence),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String valeur) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppCouleurs.bordure),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppCouleurs.primaire, size: 22),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: AppCouleurs.texteSecond, fontSize: 12)),
              Text(valeur,
                  style: const TextStyle(
                      color: AppCouleurs.textePrincipal,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}