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
      // efuKR7wpo50:APA91bH3H3FegRGuyEQQP0v2NXtOhL0YPCwmcuLVDGEtd407bZSl4lgysoIDGwOQwvW5UPC6V-OOTkxUbXxnOSRYCiXFeZWk-1h4u81KC3TnhQiywC3I4Ld5IwWz2tYFaixNV4M8MSQ9 < Emulador
      // e-1jIZAODSc:APA91bG97CpZtLTlJmjwo1Q73YTT07Itkxatu9LblaFCLdGP9cPgcobS85R7s9qlxFAFnCDiVR2rID5Qboz3V-Swn5LBguUsSZylrdrH6vPhPJm4qP1VtVKOT4cuB25p1vcz1C5g4ZfL < Android Fisico
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

        // final noti = info['data']['medicamento'];
        // _mensajesStreamController.sink.add(noti);

      },

      onResume: ( info ) {
        print('============== On Resume ==============');
        print(info);

        final noti = info['data']['medicamento'];
        _mensajesStreamController.sink.add(noti);

      },

    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }

}