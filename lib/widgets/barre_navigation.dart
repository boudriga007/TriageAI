import 'package:flutter/material.dart';
import 'package:triage_ai/const/couleurs.dart';
import 'package:triage_ai/pages/home_page.dart';
import 'package:triage_ai/pages/historique_page.dart';
import 'package:triage_ai/pages/profil_page.dart';

class BarreNavigation extends StatefulWidget {
  const BarreNavigation({super.key});

  @override
  State<BarreNavigation> createState() => _BarreNavigationState();
}

class _BarreNavigationState extends State<BarreNavigation> {
  int _indexSelectionne = 0;

  final List<Widget> _pages = const [
    HomePage(),
    HistoriquePage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_indexSelectionne],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppCouleurs.primaire,
        unselectedItemColor: AppCouleurs.texteSecond,
        currentIndex: _indexSelectionne,
        onTap: (index) {
          setState(() {
            _indexSelectionne = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}