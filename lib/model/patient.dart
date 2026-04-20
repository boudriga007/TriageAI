class Patient {
  final String nom;
  final int age;
  final String sexe;

  Patient({
    required this.nom,
    required this.age,
    required this.sexe,
  });

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'age': age,
    'sexe': sexe,
  };
}