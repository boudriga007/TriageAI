class Reponse {
  final String questionId;
  final String valeur;

  Reponse({
    required this.questionId,
    required this.valeur,
  });

  Map<String, dynamic> toJson() => {
    'question_id': questionId,
    'valeur': valeur,
  };
}