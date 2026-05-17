import 'package:triage_ai/model/question.dart';

class QuestionnaireLogic {
  static List<Question> getQuestions() {
    return [

      // ─────────────────────────────────────
      // 🔴 CATÉGORIE : DOULEUR (4 questions)
      // ─────────────────────────────────────
      Question(
        id: 'q_douleur_poitrine',
        texte: 'Ressentez-vous une douleur dans la poitrine ?',
        choix: ['oui', 'non'],
        categorie: 'Douleur',
        estCritique: true,
      ),
      Question(
        id: 'q_douleur_intensite',
        texte: 'Comment évaluez-vous l\'intensité de votre douleur ?',
        choix: ['légère', 'modérée', 'intense', 'insupportable'],
        categorie: 'Douleur',
        estCritique: false,
      ),
      Question(
        id: 'q_douleur_localisation',
        texte: 'Où se situe principalement votre douleur ?',
        choix: ['tête', 'poitrine', 'abdomen', 'membres', 'dos'],
        categorie: 'Douleur',
        estCritique: false,
      ),
      Question(
        id: 'q_douleur_duree',
        texte: 'Depuis combien de temps avez-vous cette douleur ?',
        choix: ['moins de 1h', '1 à 6h', '6 à 24h', 'plus de 24h'],
        categorie: 'Douleur',
        estCritique: false,
      ),

      // ─────────────────────────────────────────
      // 🫁 CATÉGORIE : RESPIRATOIRE (3 questions)
      // ─────────────────────────────────────────
      Question(
        id: 'q_difficulte_respirer',
        texte: 'Avez-vous des difficultés à respirer ?',
        choix: ['oui', 'non'],
        categorie: 'Respiratoire',
        estCritique: true,
      ),
      Question(
        id: 'q_respiration_repos',
        texte: 'Cette difficulté à respirer survient-elle même au repos ?',
        choix: ['oui', 'non', 'seulement à l\'effort'],
        categorie: 'Respiratoire',
        estCritique: true,
      ),
      Question(
        id: 'q_toux',
        texte: 'Avez-vous une toux persistante ou des crachats ?',
        choix: ['non', 'toux sèche', 'toux avec crachats clairs',
            'toux avec crachats colorés ou sanglants'],
        categorie: 'Respiratoire',
        estCritique: false,
      ),

      // ──────────────────────────────────────────
      // 🧠 CATÉGORIE : NEUROLOGIQUE (3 questions)
      // ──────────────────────────────────────────
      Question(
        id: 'q_perte_connaissance',
        texte: 'Avez-vous perdu connaissance récemment ?',
        choix: ['oui', 'non'],
        categorie: 'Neurologique',
        estCritique: true,
      ),
      Question(
        id: 'q_maux_tete',
        texte: 'Souffrez-vous de maux de tête inhabituels ou très intenses ?',
        choix: ['non', 'légers', 'intenses', 'les pires de ma vie'],
        categorie: 'Neurologique',
        estCritique: true,
      ),
      Question(
        id: 'q_trouble_vision_parole',
        texte: 'Avez-vous des troubles de la vision, de la parole '
            'ou une faiblesse d\'un côté du corps ?',
        choix: ['oui', 'non'],
        categorie: 'Neurologique',
        estCritique: true,
      ),

      // ─────────────────────────────────────
      // 🫃 CATÉGORIE : DIGESTIF (3 questions)
      // ─────────────────────────────────────
      Question(
        id: 'q_nausee_vomissement',
        texte: 'Avez-vous des nausées ou des vomissements ?',
        choix: ['non', 'nausées seulement', 'vomissements occasionnels',
            'vomissements répétés'],
        categorie: 'Digestif',
        estCritique: false,
      ),
      Question(
        id: 'q_douleur_abdominale',
        texte: 'Avez-vous des douleurs abdominales ?',
        choix: ['non', 'légères', 'modérées', 'très intenses'],
        categorie: 'Digestif',
        estCritique: false,
      ),
      Question(
        id: 'q_saignement_digestif',
        texte: 'Avez-vous remarqué du sang dans vos selles ou '
            'des vomissements de sang ?',
        choix: ['oui', 'non'],
        categorie: 'Digestif',
        estCritique: true,
      ),

      // ──────────────────────────────────────
      // 🌡️ CATÉGORIE : GÉNÉRAL (4 questions)
      // ──────────────────────────────────────
      Question(
        id: 'q_fievre',
        texte: 'Avez-vous de la fièvre ?',
        choix: ['non', 'légère (37.5 - 38°C)', 'modérée (38 - 39°C)',
            'élevée (plus de 39°C)'],
        categorie: 'Général',
        estCritique: false,
      ),
      Question(
        id: 'q_saignement',
        texte: 'Avez-vous un saignement important ou incontrôlable ?',
        choix: ['oui', 'non'],
        categorie: 'Général',
        estCritique: true,
      ),
      Question(
        id: 'q_duree_symptomes',
        texte: 'Depuis combien de temps avez-vous ces symptômes ?',
        choix: ['moins de 24h', '1 à 3 jours', '3 à 7 jours',
            'plus d\'une semaine'],
        categorie: 'Général',
        estCritique: false,
      ),
      Question(
        id: 'q_etat_general',
        texte: 'Comment décririez-vous votre état général en ce moment ?',
        choix: ['correct', 'fatigué', 'très fatigué', 'état grave'],
        categorie: 'Général',
        estCritique: false,
      ),
    ];
  }
}