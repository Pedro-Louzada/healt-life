import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutricao_app/pages/principal_Page.dart';
import 'package:nutricao_app/database/dbController.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import 'add_menu.dart';

List<String> tipo = ['Bebida', 'Proteína', 'Carboidrato', 'Fruta', 'Grão'];

List<String> categoria = ['Café', 'Almoço', 'Janta'];

class AddFoods extends StatefulWidget {
  const AddFoods({super.key});

  @override
  State<AddFoods> createState() => _AddFoodsState();
}

class _AddFoodsState extends State<AddFoods> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  @override
  void initState() {
    nomeController = TextEditingController();
    fotoController = TextEditingController();
    categoriaController = TextEditingController();
    tipoController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    'Adicione o alimento',
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
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 85, 84, 84), fontSize: 16),
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Digite seu nome completo',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 128, 128, 128),
                        fontSize: 15),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color.fromRGBO(255, 209, 143, 100),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: fotoController,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Foto',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'URL da foto',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 128, 128, 128),
                        fontSize: 15),
                    prefixIcon: Icon(Icons.photo),
                    prefixIconColor: Color.fromRGBO(255, 209, 143, 100),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField(
                  hint: Text('Escolha o tipo do alimento'),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20.0))),
                  items: tipo.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    Text(value!);
                    tipoController.text = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButtonFormField(
                  hint: const Text('Escolha a categoria do alimento'),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20.0))),
                  items:
                      categoria.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    Text(value!);
                    categoriaController.text = value;
                  },
                ),
                const SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(255, 209, 143, 100)
                    )
                  ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddMenu(),
                        )),
                    child: Text('Adicionar novo cardápio', style: TextStyle(fontSize: 16),)),
                    const SizedBox(
                  height: 5,
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
