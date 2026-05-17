import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/services/auth_service.dart';
import 'package:triage_ai/pages/login_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _nom    = '';
  String _email  = '';
  String _sexe   = '';
  int    _age    = 0;
  bool   _loading = true;

  @override
  void initState() {
    super.initState();
    _chargerProfil();
  }

  Future<void> _chargerProfil() async {
    final nom   = await AuthService.nomComplet;
    final email = await AuthService.email;
    final sexe  = await AuthService.sexe;
    final age   = await AuthService.age;
    setState(() {
      _nom    = nom;
      _email  = email;
      _sexe   = sexe;
      _age    = age;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
                color: AppCouleurs.primaire)),
      );
    }

    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(          // ← FIX overflow
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 48,
              backgroundColor: AppCouleurs.primaire,
              child: Text(
                _nom.isNotEmpty ? _nom[0].toUpperCase() : 'P',
                style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              _nom,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppCouleurs.textePrincipal,
              ),
            ),
            const SizedBox(height: 4),
            Text(_email,
                style: const TextStyle(
                    color: AppCouleurs.texteSecond, fontSize: 14)),

            const SizedBox(height: 32),

            _infoTile(Icons.cake_outlined, 'Âge', '$_age ans'),
            _infoTile(Icons.person_outline, 'Sexe',
                _sexe == 'male' ? 'Homme' : 'Femme'),
            _infoTile(Icons.email_outlined, 'Email', _email),

            const SizedBox(height: 32),   // ← remplace Spacer()

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await AuthService.deconnecter();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout,
                    color: AppCouleurs.urgence),
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