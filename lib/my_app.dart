import 'package:flutter/material.dart';
import 'package:nutricao_app/pages/home_page.dart';

class MeuApp extends StatelessWidget{
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela Inicial',
      home: HomePage(),
    );
  }

}