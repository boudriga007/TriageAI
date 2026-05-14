import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triage_ai/model/reponse.dart';
import 'package:triage_ai/model/triage_result.dart';
import 'package:triage_ai/model/patient.dart';

class ApiService {
  static const String _apiKey = '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'; // ← colle ta clé ici
  static const String _url = 'https://api.groq.com/openai/v1/chat/completions'; 
  static Future<TriageResult> envoyerTriage({
    required Patient patient,
    required List<Reponse> reponses,
  }) async {
    try {
      // Résumé des réponses du questionnaire
      final resumeReponses = reponses.map((r) {
        final question = r.questionId
            .replaceAll('q_', '')
            .replaceAll('_', ' ');
        return '- $question : ${r.valeur}';
      }).join('\n');

      final prompt = '''
Tu es un assistant médical de triage urgentiste. 
Voici les informations d'un patient :
- Nom : ${patient.nom}
- Âge : ${patient.age} ans
- Sexe : ${patient.sexe == 'male' ? 'Homme' : 'Femme'}

Réponses au questionnaire médical :
$resumeReponses

Analyse ces symptômes et détermine si ce patient doit :
1. Aller aux URGENCES immédiatement
2. Faire une TÉLÉCONSULTATION

Réponds UNIQUEMENT en JSON valide, sans texte avant ou après :
{
  "niveau": "urgence" ou "teleconsultation",
  "message": "diagnostic court et clair en français (max 15 mots)",
  "conseil": "conseil pratique détaillé en français (max 30 mots)"
}
''';
      print('🚀 Appel API Groq en cours...'); 

      final response = await http.post(
        Uri.https('api.groq.com', '/openai/v1/chat/completions'), 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'llama-3.3-70b-versatile', // modèle Groq gratuit
          'messages': [
            {
              'role': 'system',
              'content':
                  'Tu es un médecin urgentiste expert. Tu réponds toujours en JSON valide uniquement.',
            },
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'temperature': 0.3,
          'max_tokens': 200,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'] as String;
        print('✅ Réponse Groq : $content');

        // Nettoyage de la réponse JSON
        final jsonStr = content
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        final result = jsonDecode(jsonStr);

        return TriageResult(
          niveau: result['niveau'] == 'urgence'
              ? NiveauUrgence.urgence
              : NiveauUrgence.teleconsultation,
          message: result['message'] ?? 'Analyse complétée',
          conseil: result['conseil'] ?? '',
        );
      } else {
        print('❌ Erreur API → fallback local');
        print('❌ Status: ${response.statusCode}');        // ← ajoute
        print('❌ Body: ${response.statusCode}');  
        print('❌ Body complet: ${response.body}');  // ← change Body ici
        // ← ajoute
        // Fallback local si erreur API
        return _triageLocal(reponses);
      }
    } catch (e) {
      print('❌ Exception : $e → fallback local');
      print('❌ Type erreur : ${e.runtimeType}');        // ← ajoute

      // Fallback local si pas de connexion
      return _triageLocal(reponses);
    }
  }

  // Fallback local si API indisponible
  static TriageResult _triageLocal(List<Reponse> reponses) {
    bool urgent = reponses.any((r) =>
        r.valeur == 'oui' &&
        [
          'q_douleur_poitrine',
          'q_difficulte_respirer',
          'q_perte_connaissance',
          'q_saignement',
        ].contains(r.questionId));

    return TriageResult(
      niveau:
          urgent ? NiveauUrgence.urgence : NiveauUrgence.teleconsultation,
      message: urgent
          ? 'Consultez les urgences immédiatement'
          : 'Téléconsultation recommandée',
      conseil: urgent
          ? 'Appelez le 15 (SAMU) ou rendez-vous aux urgences.'
          : 'Prenez rendez-vous avec un médecin en ligne.',
    );
  }
}