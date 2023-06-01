import 'package:flutter/material.dart';
import 'package:nutricao_app/models/models.dart';
import 'package:nutricao_app/database/dbController.dart';
//import '../database/dbController.dart';


class cardItem extends StatefulWidget {
  cardItem({super.key});


  @override
  _cardItem createState() => _cardItem();

}

class _cardItem extends State<cardItem> {


  Future<List<Map<String, dynamic>>> getAlimentos() async {
    return Database.getLAlimentos();
  }

  @override
  void initState()   {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getAlimentos(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>>snapshot) {
          List data = snapshot.data ?? [];
          //List<AlimentosModel> alimentos = data as List<AlimentosModel>;
          debugPrint("teste");
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
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    '',
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


  