import 'package:flutter/material.dart';
import 'package:prycontrolmedico/pages/PacientesPage.dart';
import 'package:prycontrolmedico/pages/MedicamentosPage.dart';
import 'package:prycontrolmedico/pages/DosisPage.dart';
import 'package:prycontrolmedico/providers/push_notifications_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _selectedPage = 0;
  final _pageOptions = [
   PacientesPage(),
   MedicamentosPage(),
   DosisPage(),
  ];

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
  
    pushProvider.mensajes.listen( (argumento) {
      print("Argumento del Push");
      print(argumento);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control Médico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
      ),
    );
  }
}
