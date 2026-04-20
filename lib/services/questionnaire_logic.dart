import 'package:triage_ai/model/question.dart';

class QuestionnaireLogic {
  static List<Question> getQuestions() {
    return [
      Question(
        id: 'q_douleur_poitrine',
        texte: 'Ressentez-vous une douleur dans la poitrine ?',
        choix: ['oui', 'non'],
        estCritique: true,
      ),
      Question(
        id: 'q_difficulte_respirer',
        texte: 'Avez-vous des difficultés à respirer ?',
        choix: ['oui', 'non'],
        estCritique: true,
      ),
      Question(
        id: 'q_perte_connaissance',
        texte: 'Avez-vous perdu connaissance récemment ?',
        choix: ['oui', 'non'],
        estCritique: true,
      ),
      Question(
        id: 'q_fievre',
        texte: 'Avez-vous de la fièvre (> 38°C) ?',
        choix: ['oui', 'non'],
        estCritique: false,
      ),
      Question(
        id: 'q_saignement',
        texte: 'Avez-vous un saignement important ?',
        choix: ['oui', 'non'],
        estCritique: true,
      ),
      Question(
        id: 'q_douleur_intensite',
        texte: 'Comment évaluez-vous votre douleur ?',
        choix: ['légère', 'modérée', 'intense'],
        estCritique: false,
      ),
      Question(
        id: 'q_duree_symptomes',
        texte: 'Depuis combien de temps avez-vous ces symptômes ?',
        choix: ['moins de 24h', '1 à 3 jours', 'plus de 3 jours'],
        estCritique: false,
      ),
    ];
  }
}