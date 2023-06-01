import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutricao_app/pages/login_page.dart';
import 'firebase_options.dart';
import 'package:nutricao_app/database/dbController.dart';
import 'package:flutter/foundation.dart';

import 'models/models.dart';


void main() {

  //Future<List<AlimentosModel>> listaAlimentos = Database.getAlimentos();
  
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  //Database.database();
  //debugPrint(listaAlimentos.toString());
  //Database.getCardapio();

  runApp(
    const MaterialApp(
      title: 'Healthly App',
      home: LoginPage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const LoginPage();
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
