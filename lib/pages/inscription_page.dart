import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/services/auth_service.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _nomController      = TextEditingController();
  final _prenomController   = TextEditingController();
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();

  bool _motDePasseVisible = false;
  String _sexe = 'male';
  DateTime? _dateNaissance;
  String? _erreur;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _choisirDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      helpText: 'Date de naissance',
    );
    if (date != null) setState(() => _dateNaissance = date);
  }

  void _inscrire() {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _dateNaissance == null) {
      setState(() => _erreur = 'Veuillez remplir tous les champs.');
      return;
    }

    final ok = AuthService.inscrire(
      nom: _nomController.text.trim(),
      prenom: _prenomController.text.trim(),
      email: _emailController.text.trim(),
      motDePasse: _passwordController.text.trim(),
      dateNaissance: _dateNaissance!.toIso8601String().split('T')[0],
      sexe: _sexe,
    );

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compte créé ! Connectez-vous.'),
          backgroundColor: AppCouleurs.teleconsult,
        ),
      );
      Navigator.pop(context);
    } else {
      setState(() => _erreur = 'Cet email est déjà utilisé.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Créer un compte'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Prénom
            TextField(
              controller: _prenomController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),

            // Nom
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom de famille',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),

            // Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),

            // Mot de passe
            TextField(
              controller: _passwordController,
              obscureText: !_motDePasseVisible,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_motDePasseVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () => setState(
                      () => _motDePasseVisible = !_motDePasseVisible),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 14),

            // Date de naissance
            GestureDetector(
              onTap: _choisirDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppCouleurs.bordure),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.cake_outlined,
                        color: AppCouleurs.texteSecond),
                    const SizedBox(width: 12),
                    Text(
                      _dateNaissance == null
                          ? 'Date de naissance'
                          : '${_dateNaissance!.day.toString().padLeft(2, '0')}/'
                              '${_dateNaissance!.month.toString().padLeft(2, '0')}/'
                              '${_dateNaissance!.year}',
                      style: TextStyle(
                        color: _dateNaissance == null
                            ? AppCouleurs.texteSecond
                            : AppCouleurs.textePrincipal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Sexe
            const Text('Sexe',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppCouleurs.textePrincipal)),
            const SizedBox(height: 8),
            Row(
              children: [
                _sexeBtn('male', 'Homme', Icons.male),
                const SizedBox(width: 12),
                _sexeBtn('female', 'Femme', Icons.female),
              ],
            ),

            // Erreur
            if (_erreur != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppCouleurs.urgence.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: AppCouleurs.urgence, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(_erreur!,
                          style: const TextStyle(
                              color: AppCouleurs.urgence, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _inscrire,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppCouleurs.primaire,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Créer le compte',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sexeBtn(String valeur, String label, IconData icon) {
    final sel = _sexe == valeur;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _sexe = valeur),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: sel ? AppCouleurs.primaire : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: sel ? AppCouleurs.primaire : AppCouleurs.bordure),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: sel ? Colors.white : AppCouleurs.texteSecond),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      color: sel
                          ? Colors.white
                          : AppCouleurs.textePrincipal,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}