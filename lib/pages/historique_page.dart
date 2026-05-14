import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/services/auth_service.dart';
import 'package:triage_ai/services/historique_service.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  List<HistoriqueEntry> _historique = [];
  bool _chargement = true;

  @override
  void initState() {
    super.initState();
    _chargerHistorique();
  }

  Future<void> _chargerHistorique() async {
    final emailUser = await AuthService.email;
    final liste     = await HistoriqueService.charger(emailUser);
    setState(() {
      _historique = liste;
      _chargement = false;
    });
  }

  String _formaterDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return isoDate;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}  '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCouleurs.fond,
      appBar: AppBar(
        title: const Text('Historique'),
        backgroundColor: AppCouleurs.primaire,
        foregroundColor: Colors.white,
      ),
      body: _chargement
          ? const Center(
              child: CircularProgressIndicator(
                  color: AppCouleurs.primaire))
          : _historique.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history,
                          size: 64,
                          color: AppCouleurs.texteSecond),
                      SizedBox(height: 16),
                      Text(
                        'Aucun triage effectué',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppCouleurs.texteSecond,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _historique.length,
                  itemBuilder: (context, index) {
                    final entry     = _historique[index];
                    final estUrgence = entry.niveau == 'urgence';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: estUrgence
                              ? AppCouleurs.urgence.withOpacity(0.3)
                              : AppCouleurs.teleconsult
                                  .withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: estUrgence
                                  ? AppCouleurs.urgence
                                      .withOpacity(0.1)
                                  : AppCouleurs.teleconsult
                                      .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              estUrgence
                                  ? Icons.local_hospital
                                  : Icons.video_call_outlined,
                              color: estUrgence
                                  ? AppCouleurs.urgence
                                  : AppCouleurs.teleconsult,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  estUrgence
                                      ? 'Urgences'
                                      : 'Téléconsultation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: estUrgence
                                        ? AppCouleurs.urgence
                                        : AppCouleurs.teleconsult,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  entry.message,
                                  style: const TextStyle(
                                      color:
                                          AppCouleurs.textePrincipal,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formaterDate(entry.date),
                                  style: const TextStyle(
                                      color: AppCouleurs.texteSecond,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}