import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Inscription
  static Future<bool> inscrire({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String dateNaissance,
    required String sexe,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: motDePasse,
      );

      // Sauvegarder les infos supplémentaires dans Firestore
      await _db.collection('utilisateurs').doc(credential.user!.uid).set({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'dateNaissance': dateNaissance,
        'sexe': sexe,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      print('❌ Erreur inscription : ${e.code}');
      return false;
    }
  }

  // Connexion
  static Future<bool> connecter({
    required String email,
    required String motDePasse,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: motDePasse,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('❌ Erreur connexion : ${e.code}');
      return false;
    }
  }

  // Déconnexion
  static Future<void> deconnecter() async {
    await _auth.signOut();
  }

  // Récupérer les infos de l'utilisateur connecté depuis Firestore
  static Future<Map<String, dynamic>> getUtilisateurConnecte() async {
    final user = _auth.currentUser;
    if (user == null) return {};

    final doc = await _db.collection('utilisateurs').doc(user.uid).get();
    if (!doc.exists) return {};
    return doc.data() ?? {};
  }

  static bool get estConnecteSync => _auth.currentUser != null;

  static Future<bool> get estConnecte async {
    return _auth.currentUser != null;
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
    return _auth.currentUser?.email ?? '';
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