import 'package:flutter/material.dart';
import 'package:nutricao_app/components/principal_Page.dart';
import 'package:nutricao_app/database/dbController.dart';

import '../models/models.dart';

class cardItem extends StatefulWidget {
  cardItem({super.key});

  @override
  _cardItem createState() => _cardItem();
}

class _cardItem extends State<cardItem> {
  
  Future<List<Map<String, dynamic>>> getAlimentos() async {
    Database.database();
    return Database.getAlimentos();
  }

  @override
  void initState() {
    super.initState();
    getAlimentos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAlimentos(),
        builder: ((context, snapshot) {
          List data = snapshot.data ?? [];
          return ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Ink.image(
                            image: NetworkImage(data[index]['foto']),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(data[index]['nome'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(data[index]['categoria'],
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20,
                            ),
                            Dismissible(
                                key: Key(data[index].toString()),
                                onDismissed: (direction) {
                                  Database.deleteAlimentoByID(data[index]['id']);
                                },
                                child: IconButton(
                                  icon: Icon(Icons.delete,
                                      color:
                                          Color.fromRGBO(250, 159, 32, 0.726)),
                                  onPressed: () {
                                    Database.deleteAlimentoByID(data[index]['id']);
                                    setState(() {});
                                  },
                                )),
                          ],
                        ),
                      )
                    ],
                  ));
            },
          );
        }));
  }
}
