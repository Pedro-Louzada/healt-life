import 'package:flutter/material.dart';

class Credito extends StatelessWidget {
  const Credito({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(156, 247, 151, 18),
          leading: IconButton(icon:
            const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Créditos')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Criadores / Desenvolvedores",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Text(
              "Éverton Simplicio da Silva \n Lucas Vinicius Pisciotta \n Luiz Guilherme do Nascimento Ribeiro \n Maxwell Barbosa Silva \n Mateus Souza da Silva Pedro Louzada \n Renan Souza de Oliveira \n Yago Giraud da Fonseca \n",
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
