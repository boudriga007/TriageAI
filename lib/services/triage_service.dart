import 'package:triage_ai/model/reponse.dart';
import 'package:triage_ai/model/triage_result.dart';
import 'package:triage_ai/model/patient.dart';
import 'api_service.dart';

class TriageService {
  final List<Reponse> _reponses = [];
  Patient? _patient;

  void setPatient(Patient patient) {
    _patient = patient;
  }

  void ajouterReponse(Reponse reponse) {
    _reponses.removeWhere((r) => r.questionId == reponse.questionId);
    _reponses.add(reponse);
  }

  List<Reponse> get reponses => List.unmodifiable(_reponses);

  void reinitialiser() {
    _reponses.clear();
    _patient = null;
  }

  Future<TriageResult> calculerTriage() async {
    if (_patient == null) {
      return TriageResult(
        niveau: NiveauUrgence.inconnu,
        message: 'Patient non défini',
        conseil: 'Veuillez renseigner vos informations.',
      );
    }
    return await ApiService.envoyerTriage(
      patient: _patient!,
      reponses: _reponses,
    );
  }
}