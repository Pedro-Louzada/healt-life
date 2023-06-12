import 'package:flutter/material.dart';

import '../database/dbController.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController search = TextEditingController();
  List<String> category = ['Usuários', 'Alimentos', 'Cardápios'];
  String chooseCategory = '';

  Future<List<Map<String, dynamic>>> getUsuarioByLike(search) async {
    Database.database();
    return Database.getUsuarioByLike(search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Container(
            height: 250,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 100, left: 15),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                      onChanged: (value) {
                        search.text = value;
                      },
                      controller: search,
                      decoration: InputDecoration(
                          hintText:
                              'Pesquise por usuários, alimentos ou cardapios',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20.0)))),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text('Selecione o que deseja pesquisar'),
                      items: category.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        chooseCategory = value!;
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: getUsuarioByLike(search.text),
                      builder: ((context, snapshot) {
                        List data = snapshot.data ?? [];
                        if (snapshot.hasData && snapshot.data == null) {
                          return SizedBox(
                            height: 10,
                          );
                        }
                        return ListView.builder(
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(data[index]['nome']),
                            );
                          },
                        );
                      }),
                    ),
                  )
                ],
              ),
            ))
      ],
    )));
  }
}
