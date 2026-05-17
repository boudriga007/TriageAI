class Question {
  final String id;
  final String texte;
  final List<String> choix;
  final bool estCritique;
  final String categorie;

  Question({
    required this.id,
    required this.texte,
    required this.choix,
    required this.categorie,
    this.estCritique = false,
  });
}