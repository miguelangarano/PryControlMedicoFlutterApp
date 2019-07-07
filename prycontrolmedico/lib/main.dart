import 'package:flutter/material.dart';
import 'package:prycontrolmedico/pages/HomePage.dart';
import 'package:prycontrolmedico/pages/MensajePage.dart';
import 'package:prycontrolmedico/providers/push_notifications_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
  
    pushProvider.mensajes.listen( (data) {
      print("Argumento del Push");
      print(data);

      navigatorKey.currentState.pushNamed('mensaje', arguments: data);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Control Médico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mensaje': (BuildContext context) => MensajePage(),
      }
    );
  }
}
