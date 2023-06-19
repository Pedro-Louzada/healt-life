import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutricao_app/models/models.dart';
import 'package:nutricao_app/pages/principal_Page.dart';
import 'package:nutricao_app/database/dbController.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:nutricao_app/database/dbController.dart';
import 'package:custom_radio_group_list/custom_radio_group_list.dart';

List<String> tipo = ['Bebida', 'Proteína', 'Carboidrato', 'Fruta', 'Grão'];

List<String> categoria = ['Café', 'Almoço', 'Janta'];

List<String> selections = [];
String select = '';
int idUser = 0;
int count = 1;

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  Future<List<Map<String, dynamic>>> getUsuarios() async {
    Database.database();
    return Database.getUsuarios();
  }

  Future<List<Map<String, dynamic>>> getAlimentosByCategory(
      String categoria) async {
    Database.database();
    return Database.getAlimentosByCategory(categoria);
  }

  String chooseUser = '';
  String sqlCategory = '';

  @override
  void initState() {
    getUsuarios();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Crie o cardápio',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(250, 168, 53, 0.612)),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonHideUnderline(
                  child: FutureBuilder(
                    future: getUsuarios(),
                    builder: (context, snapshot) {
                      List data = snapshot.data ?? [];
                      return Container(
                        child: DropdownButton(
                          hint: Text('Aponte o usuário'),
                          items: snapshot.data
                              ?.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['nome'],
                              child: Text(value['nome']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {});
                            chooseUser = value!;
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  hint: const Text('Filtre a categoria'),
                  items: categoria
                      .map<DropdownMenuItem<String>>((String categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                  onChanged: (value) {
                    sqlCategory = value!;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Usuário > ' + chooseUser, style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 335),
                    child: FutureBuilder(
                        future: getAlimentosByCategory(sqlCategory),
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
                                            image: NetworkImage(
                                                data[index]['foto']),
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(data[index]['categoria'],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Radio(
                                              activeColor: Color.fromRGBO(
                                                  170, 134, 84, 0.824),
                                              value: data[index]['nome'],
                                              groupValue: select,
                                              onChanged: (value) {
                                                setState(() {
                                                  select = value!;
                                                  idUser = data[index]['id'];
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ));
                            },
                          );
                        })),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (chooseUser.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('É necessário selecionar um usuário')),
                      );
                    } else {
                      Database.insertCardapio(
                          idUser, 'Cardapio $count', select, sqlCategory);
                      count++;

                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Cardapio criado com sucesso!')),
                    );
                    }

                    
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        return Color.fromRGBO(255, 209, 143, 100);
                      }),
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: const Text('Criar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans')),
                ),
              ],
            ),
          )),
    );
  }
}
