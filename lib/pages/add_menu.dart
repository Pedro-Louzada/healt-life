import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutricao_app/components/principal_Page.dart';
import 'package:nutricao_app/database/dbController.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:nutricao_app/database/dbController.dart';

List<String> tipo = ['Bebida', 'Proteína', 'Carboidrato', 'Fruta', 'Grão'];

List<String> categoria = ['Café', 'Almoço', 'Janta'];

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

  TextEditingController nomeController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  String chooseUser = '';

  @override
  void initState() {
    nomeController = TextEditingController();
    fotoController = TextEditingController();
    categoriaController = TextEditingController();
    tipoController = TextEditingController();
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

                DropdownButtonHideUnderline(child: FutureBuilder(
                  future: getUsuarios(),
                  builder: (context, snapshot) {
                    List data = snapshot.data ?? [];
                    return Container(
                      child: DropdownButton(hint: Text('Aponte o usuário'),items: snapshot.data?.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['nome'],
                              child: Text(value['nome']),
                            );
                          }).toList(), onChanged: (value) {
                            chooseUser = value!;
                          },),
                    );
                  },
                ),),
                const SizedBox(
                  height: 25,
                ),
                
                ElevatedButton(
                  onPressed: () async {
                    final nome = nomeController.text;
                    final foto = fotoController.text;
                    final categoria = categoriaController.text;
                    final tipo = tipoController.text;

                    Database.insertAlimentos(nome, foto, categoria, tipo);

                    setState(() {
                      nomeController = TextEditingController();
                      fotoController = TextEditingController();
                      categoriaController = TextEditingController();
                      tipoController = TextEditingController();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Alimento criado com sucesso!')),
                    );
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
