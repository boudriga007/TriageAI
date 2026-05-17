import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:triage_ai/model/triage_result.dart';

class HistoriqueEntry {
  final String date;
  final String niveau;
  final String message;
  final String conseil;
  final String email;

  HistoriqueEntry({
    required this.date,
    required this.niveau,
    required this.message,
    required this.conseil,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'niveau': niveau,
    'message': message,
    'conseil': conseil,
    'email': email,
  };

  factory HistoriqueEntry.fromJson(Map<String, dynamic> json) {
    return HistoriqueEntry(
      date: json['date'] ?? '',
      niveau: json['niveau'] ?? '',
      message: json['message'] ?? '',
      conseil: json['conseil'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class HistoriqueService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sauvegarder un triage dans Firestore
  static Future<void> sauvegarder({
    required TriageResult resultat,
    required String email,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('historique')
        .add({
      'date': DateTime.now().toIso8601String(),
      'timestamp': FieldValue.serverTimestamp(),
      'niveau': resultat.niveau == NiveauUrgence.urgence
          ? 'urgence'
          : 'teleconsultation',
      'message': resultat.message,
      'conseil': resultat.conseil,
      'email': email,
    });
  }

  // Charger l'historique de l'utilisateur connecté
  static Future<List<HistoriqueEntry>> charger(String email) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _db
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('historique')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => HistoriqueEntry.fromJson(doc.data()))
        .toList();
  }

  // Vider l'historique
  static Future<void> vider() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await _db
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('historique')
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}