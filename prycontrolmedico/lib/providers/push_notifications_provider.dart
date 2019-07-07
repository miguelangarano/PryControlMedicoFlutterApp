import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider{


  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then( (token) {
      print('===== FCM Token =====');
      print( token );
      // efuKR7wpo50:APA91bH3H3FegRGuyEQQP0v2NXtOhL0YPCwmcuLVDGEtd407bZSl4lgysoIDGwOQwvW5UPC6V-OOTkxUbXxnOSRYCiXFeZWk-1h4u81KC3TnhQiywC3I4Ld5IwWz2tYFaixNV4M8MSQ9
    });

    _firebaseMessaging.configure(

      onMessage: ( info ) {
        print('============== On Message ==============');
        print(info);

        String argumento = 'no-data';
        if ( Platform.isAndroid ){
          argumento = info['data']['medicamento'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);

      },

      onLaunch: ( info ) {
        print('============== On Launch ==============');
        print(info);

      },

      onResume: ( info ) {
        print('============== On Resume ==============');
        print(info);

        // final medicamento = info['data']['medicamento'];
        // print(medicamento);

      },

    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }

}