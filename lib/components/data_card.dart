import 'package:flutter/material.dart';
import 'package:nutricao_app/pages/principal_Page.dart';
import 'package:nutricao_app/database/dbController.dart';
import 'package:share_plus/share_plus.dart';

import '../models/models.dart';

class cardItem extends StatefulWidget {
  cardItem({super.key});

  @override
  _cardItem createState() => _cardItem();
}

class _cardItem extends State<cardItem> {
  Future<List<Map<String, dynamic>>> getAlimentosByCategory(
      String categoria) async {
    Database.database();
    return Database.getAlimentosByCategory(categoria);
  }

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    Database.database();
    return Database.getUsuarios();
  }

  String chooseUser = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 35, left: 35),
          child: const Text(
            'Café',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 20,
                color: Colors.black),
          ),
        ),
        Row(children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 325),
                  child: FutureBuilder(
                      future: getAlimentosByCategory('Café'),
                      builder: ((context, snapshot) {
                        List data = snapshot.data ?? [];
                        if (data.isEmpty) {
                          return SizedBox(
                            height: 10,
                          );
                        }
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
                                          image:
                                              NetworkImage(data[index]['foto']),
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
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text(data[index]['categoria'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Database.deleteAlimentoByID(
                                                    data[index]['id']);
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      })))),
        ]),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 35, left: 35),
          child: const Text(
            'Almoço',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 20,
                color: Colors.black),
          ),
        ),
        Row(children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 325),
                  child: FutureBuilder(
                      future: getAlimentosByCategory('Almoço'),
                      builder: ((context, snapshot) {
                        List data = snapshot.data ?? [];
                        if (data.isEmpty) {
                          return SizedBox(
                            height: 10,
                          );
                        }
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
                                          image:
                                              NetworkImage(data[index]['foto']),
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
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text(data[index]['categoria'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Database.deleteAlimentoByID(
                                                    data[index]['id']);
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      })))),
        ]),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(top: 35, left: 35),
          child: const Text(
            'Janta',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 20,
                color: Colors.black),
          ),
        ),
        Row(children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 325),
                  child: FutureBuilder(
                      future: getAlimentosByCategory('Janta'),
                      builder: ((context, snapshot) {
                        List data = snapshot.data ?? [];
                        if (data.isEmpty) {
                          return SizedBox(
                            height: 10,
                          );
                        }
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
                                          image:
                                              NetworkImage(data[index]['foto']),
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
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text(data[index]['categoria'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Database.deleteAlimentoByID(
                                                    data[index]['id']);
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.delete))
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      })))),
        ])
      ],
    );
  }
}
