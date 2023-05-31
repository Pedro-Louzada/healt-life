import 'package:flutter/material.dart';

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Stack(
        children: [
          Container(
            height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/43/bc/57/43bc573f4dae2ad70361e7113db688cb.jpg'))),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 50, left: 25),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, Renan',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.black),
                    ),
                     Text(
                      'Seja bem vindo!',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(40),
              ),
            ),
            child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10, left: 35),
                child: Text(
                  'Recomendados',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20, left: 25),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 305,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            cardItem(
                                'https://i.pinimg.com/564x/73/35/34/73353454e5844ea81ce617517931f1c4.jpg'),
                            SizedBox(width: 12),
                            cardItem(
                                'https://i.pinimg.com/564x/7f/ab/25/7fab256cb01b1c9a23c5a18c0c0d205c.jpg'),
                            SizedBox(width: 12),
                            cardItem(
                                'https://i.pinimg.com/564x/31/64/3a/31643ade701bc5b8c8246c3f8410961b.jpg'),
                            SizedBox(width: 12),
                            cardItem(
                                'https://i.pinimg.com/564x/0c/d7/73/0cd773d7ba87cc5ae268c21c1635500c.jpg')
                          ],
                        ),
                      )))
            ],
          ),
          )
          
        ],
      ),
    )));
  }

  Widget cardItem(imagem) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(imagem),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'Pão com ovo',
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
}
