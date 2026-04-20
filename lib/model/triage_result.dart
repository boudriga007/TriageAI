enum NiveauUrgence { urgence, teleconsultation, inconnu }

class TriageResult {
  final NiveauUrgence niveau;
  final String message;
  final String conseil;

  TriageResult({
    required this.niveau,
    required this.message,
    required this.conseil,
  });

  factory TriageResult.fromJson(Map<String, dynamic> json) {
    return TriageResult(
      niveau: json['niveau'] == 'urgence'
          ? NiveauUrgence.urgence
          : NiveauUrgence.teleconsultation,
      message: json['message'] ?? '',
      conseil: json['conseil'] ?? '',
    );
  }
}