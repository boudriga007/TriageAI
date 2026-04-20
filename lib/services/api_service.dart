import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triage_ai/model/reponse.dart';
import 'package:triage_ai/model/triage_result.dart';
import 'package:triage_ai/model/patient.dart';

class ApiService {
  // On utilise l'API publique d'Infermedica (triage médical)
  // Inscription gratuite sur : https://developer.infermedica.com
  static const String _baseUrl = 'https://api.infermedica.com/v3';
  static const String _appId  = 'VOTRE_APP_ID';   // à remplacer
  static const String _appKey = 'VOTRE_APP_KEY';  // à remplacer

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'App-Id': _appId,
    'App-Key': _appKey,
  };

  // Envoyer les réponses et obtenir le résultat de triage
  static Future<TriageResult> envoyerTriage({
    required Patient patient,
    required List<Reponse> reponses,
  }) async {
    try {
      final body = jsonEncode({
        'sex': patient.sexe,
        'age': {'value': patient.age},
        'evidence': reponses.map((r) => {
          'id': r.questionId,
          'choice_id': r.valeur,
          'source': 'initial',
        }).toList(),
      });

      final response = await http.post(
        Uri.parse('$_baseUrl/triage'),
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TriageResult(
          niveau: data['triage_level'] == 'emergency'
              ? NiveauUrgence.urgence
              : NiveauUrgence.teleconsultation,
          message: data['label'] ?? 'Résultat obtenu',
          conseil: data['description'] ?? '',
        );
      } else {
        return _triageLocal(reponses);
      }
    } catch (e) {
      return _triageLocal(reponses);
    }
  }

  // Fallback local si pas d'API disponible
  static TriageResult _triageLocal(List<Reponse> reponses) {
    bool urgent = reponses.any((r) =>
      r.valeur == 'oui' &&
      ['q_douleur_poitrine', 'q_difficulte_respirer',
       'q_perte_connaissance', 'q_saignement'].contains(r.questionId)
    );
    return TriageResult(
      niveau: urgent ? NiveauUrgence.urgence : NiveauUrgence.teleconsultation,
      message: urgent ? 'Consultez les urgences immédiatement' : 'Téléconsultation recommandée',
      conseil: urgent
          ? 'Appelez le 15 (SAMU) ou rendez-vous aux urgences.'
          : 'Prenez rendez-vous avec un médecin en ligne.',
    );
  }
}