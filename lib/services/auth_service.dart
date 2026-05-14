import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyUtilisateurs = 'utilisateurs';
  static const String _keyConnecte     = 'utilisateur_connecte';

  // Charger tous les utilisateurs depuis le stockage
  static Future<List<Map<String, String>>> _chargerUtilisateurs() async {
    final prefs = await SharedPreferences.getInstance();
    final data  = prefs.getString(_keyUtilisateurs);
    if (data == null) {
      // Compte test par défaut
      return [
        {
          'email': 'test@test.com',
          'motDePasse': '1234',
          'nom': 'Ben Ali',
          'prenom': 'Ahmed',
          'dateNaissance': '1990-05-15',
          'sexe': 'male',
        }
      ];
    }
    final List decoded = jsonDecode(data);
    return decoded.map((e) => Map<String, String>.from(e)).toList();
  }

  // Sauvegarder tous les utilisateurs
  static Future<void> _sauvegarderUtilisateurs(
      List<Map<String, String>> utilisateurs) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUtilisateurs, jsonEncode(utilisateurs));
  }

  // Inscription
  static Future<bool> inscrire({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String dateNaissance,
    required String sexe,
  }) async {
    final utilisateurs = await _chargerUtilisateurs();
    final dejaExiste = utilisateurs.any((u) => u['email'] == email);
    if (dejaExiste) return false;

    utilisateurs.add({
      'email': email,
      'motDePasse': motDePasse,
      'nom': nom,
      'prenom': prenom,
      'dateNaissance': dateNaissance,
      'sexe': sexe,
    });

    await _sauvegarderUtilisateurs(utilisateurs);
    return true;
  }

  // Connexion
  static Future<bool> connecter({
    required String email,
    required String motDePasse,
  }) async {
    final utilisateurs = await _chargerUtilisateurs();
    final user = utilisateurs.firstWhere(
      (u) => u['email'] == email && u['motDePasse'] == motDePasse,
      orElse: () => {},
    );
    if (user.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyConnecte, email);
      return true;
    }
    return false;
  }

  // Déconnexion
  static Future<void> deconnecter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyConnecte);
  }

  // Récupérer utilisateur connecté
  static Future<Map<String, String>> getUtilisateurConnecte() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_keyConnecte);
    if (email == null) return {};
    final utilisateurs = await _chargerUtilisateurs();
    return utilisateurs.firstWhere(
      (u) => u['email'] == email,
      orElse: () => {},
    );
  }

  static Future<bool> get estConnecte async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyConnecte) != null;
  }

  static Future<String> get nomComplet async {
    final u = await getUtilisateurConnecte();
    return '${u['prenom'] ?? ''} ${u['nom'] ?? ''}'.trim();
  }

  static Future<String> get prenom async {
    final u = await getUtilisateurConnecte();
    return u['prenom'] ?? '';
  }

  static Future<String> get sexe async {
    final u = await getUtilisateurConnecte();
    return u['sexe'] ?? 'male';
  }

  static Future<String> get email async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyConnecte) ?? '';
  }

  static Future<int> get age async {
    final u = await getUtilisateurConnecte();
    final dateStr = u['dateNaissance'] ?? '';
    if (dateStr.isEmpty) return 25;
    final naissance = DateTime.tryParse(dateStr);
    if (naissance == null) return 25;
    final aujourd = DateTime.now();
    int age = aujourd.year - naissance.year;
    if (aujourd.month < naissance.month ||
        (aujourd.month == naissance.month &&
            aujourd.day < naissance.day)) {
      age--;
    }
    return age;
  }
}