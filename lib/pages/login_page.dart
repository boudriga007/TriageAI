import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/services/auth_service.dart';
import 'package:triage_ai/pages/inscription_page.dart';
import 'package:triage_ai/widgets/barre_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _motDePasseVisible   = false;
  String? _erreur;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _connecter() {
    final ok = AuthService.connecter(
      email: _emailController.text.trim(),
      motDePasse: _passwordController.text.trim(),
    );
    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BarreNavigation()),
      );
    } else {
      setState(() => _erreur = 'Email ou mot de passe incorrect.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // ── Logo uniquement ──
              Center(
                child: Image.asset(
                  'assets/img/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              // ── Titre connexion ──
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppCouleurs.textePrincipal,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Connectez-vous pour accéder à votre espace',
                  style: TextStyle(
                    color: AppCouleurs.texteSecond,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Email ──
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // ── Mot de passe ──
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              // ── Erreur ──
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
                                color: AppCouleurs.urgence,
                                fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // ── Bouton connexion ──
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _connecter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppCouleurs.primaire,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Lien inscription ──
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const InscriptionPage()),
                ),
                child: const Text.rich(
                  TextSpan(
                    text: 'Pas encore de compte ? ',
                    style: TextStyle(color: AppCouleurs.texteSecond),
                    children: [
                      TextSpan(
                        text: 'S\'inscrire',
                        style: TextStyle(
                          color: AppCouleurs.primaire,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Compte test ──

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}