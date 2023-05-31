import 'package:flutter/material.dart';
import 'package:nutricao_app/models/models.dart';

import '../database/dbController.dart';


class cardItem extends StatelessWidget {

  Future<List<AlimentosModel>> listaAlimentos = Database.getAlimentos();
  List results = [];

  void getData() async {
    Future<List<AlimentosModel>> listaAlimentos = Database.getAlimentos();
    results.add(listaAlimentos);
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: listaAlimentos,
        builder: (context, snapshot) {
          List data = snapshot.data ?? [];
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) { 
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
                child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(''),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    '{}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Vegetariano',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
              );
             },

          );
        },
          ));
    
    
    /* Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(''),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    '{}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Vegetariano',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ); */
  }
}