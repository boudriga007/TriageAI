class AuthService {
  static final List<Map<String, String>> _utilisateurs = [
    {
      'email': 'test@test.com',
      'motDePasse': '1234',
      'nom': 'Ben Ali',
      'prenom': 'Ahmed',
      'dateNaissance': '1990-05-15',
      'sexe': 'male',
    },
  ];

  static String? _emailConnecte;

  // Inscription
  static bool inscrire({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String dateNaissance,
    required String sexe,
  }) {
    final dejaExiste = _utilisateurs.any((u) => u['email'] == email);
    if (dejaExiste) return false;
    _utilisateurs.add({
      'email': email,
      'motDePasse': motDePasse,
      'nom': nom,
      'prenom': prenom,
      'dateNaissance': dateNaissance,
      'sexe': sexe,
    });
    return true;
  }

  // Connexion
  static bool connecter({
    required String email,
    required String motDePasse,
  }) {
    final user = _utilisateurs.firstWhere(
      (u) => u['email'] == email && u['motDePasse'] == motDePasse,
      orElse: () => {},
    );
    if (user.isNotEmpty) {
      _emailConnecte = email;
      return true;
    }
    return false;
  }

  static void deconnecter() => _emailConnecte = null;

  static bool get estConnecte => _emailConnecte != null;

  // Récupérer l'utilisateur connecté
  static Map<String, String> get utilisateurConnecte {
    if (_emailConnecte == null) return {};
    return _utilisateurs.firstWhere(
      (u) => u['email'] == _emailConnecte,
      orElse: () => {},
    );
  }

  // Getters pratiques
  static String get nomComplet {
    final u = utilisateurConnecte;
    return '${u['prenom'] ?? ''} ${u['nom'] ?? ''}'.trim();
  }

  static String get prenom => utilisateurConnecte['prenom'] ?? '';
  static String get sexe   => utilisateurConnecte['sexe'] ?? 'male';
  static String get email  => _emailConnecte ?? '';

  // Calcul automatique de l'âge depuis la date de naissance
  static int get age {
    final dateStr = utilisateurConnecte['dateNaissance'] ?? '';
    if (dateStr.isEmpty) return 25;
    final naissance = DateTime.tryParse(dateStr);
    if (naissance == null) return 25;
    final aujourd = DateTime.now();
    int age = aujourd.year - naissance.year;
    if (aujourd.month < naissance.month ||
        (aujourd.month == naissance.month &&
            aujourd.day < naissance.day)) {
      age--;
    }
    return age;
  }
}