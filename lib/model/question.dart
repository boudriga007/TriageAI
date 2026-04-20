class Question {
  final String id;
  final String texte;
  final List<String> choix;
  final bool estCritique;

  Question({
    required this.id,
    required this.texte,
    required this.choix,
    this.estCritique = false,
  });
}