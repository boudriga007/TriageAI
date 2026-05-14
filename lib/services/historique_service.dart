import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
  static const String _key = 'historique_triages';

  // Sauvegarder un triage
  static Future<void> sauvegarder({
    required TriageResult resultat,
    required String email,
  }) async {
    final prefs   = await SharedPreferences.getInstance();
    final data    = prefs.getString(_key);
    final List<HistoriqueEntry> liste = data == null
        ? []
        : (jsonDecode(data) as List)
            .map((e) => HistoriqueEntry.fromJson(e))
            .toList();

    liste.insert(
      0,
      HistoriqueEntry(
        date: DateTime.now().toIso8601String(),
        niveau: resultat.niveau == NiveauUrgence.urgence
            ? 'urgence'
            : 'teleconsultation',
        message: resultat.message,
        conseil: resultat.conseil,
        email: email,
      ),
    );

    await prefs.setString(
        _key, jsonEncode(liste.map((e) => e.toJson()).toList()));
  }

  // Charger l'historique d'un utilisateur
  static Future<List<HistoriqueEntry>> charger(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final data  = prefs.getString(_key);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded
        .map((e) => HistoriqueEntry.fromJson(e))
        .where((e) => e.email == email)
        .toList();
  }

  // Vider l'historique
  static Future<void> vider() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}