import 'package:flutter/material.dart';

import 'DosisPage.dart';
import 'MedicamentosPage.dart';
import 'PacientesPage.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedPage = 0;

  final _pageOptions = [
   PacientesPage(),
   MedicamentosPage(),
   DosisPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Control Médico'),),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Pacientes')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              title: Text('Medicamentos')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restore),
              title: Text('Dosis')
            ),
          ],
        ),
      );
  }
}