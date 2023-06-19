import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Future<List<Map<String, dynamic>>> getByLike(search, chooseCategory) async {
    Database.database();
    return Database.getByLike(search, chooseCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 2,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 100, left: 15),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                      onChanged: (value) {
                        getByLike(search.text, chooseCategory);
                        setState(() {});
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
                        setState(() {
                          chooseCategory = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                    child: FutureBuilder(
                      future: getByLike(search.text, chooseCategory),
                      builder: ((context, snapshot) {
                        List data = snapshot.data ?? [];
                        if (data.isEmpty) return SizedBox();
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (chooseCategory == 'Usuários') {
                              return ListTile(
                                title: Text(data[index]['nome']),
                                titleTextStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              );
                            } else if (chooseCategory == 'Cardápios') {
                              return ListTile(
                                title: Text(data[index]['nome']),
                                subtitle: Text(data[index]['alimento'] + '\nId do usuário: ' + data[index]['usu_id'].toString()),
                                titleTextStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              );
                            } else if (chooseCategory == 'Alimentos') {
                              return ListTile(
                                title: Text(data[index]['nome']),
                                subtitle: Text(data[index]['categoria']),
                                titleTextStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              );
                            }
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
