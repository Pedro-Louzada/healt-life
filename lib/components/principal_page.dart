import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutricao_app/database/dbController.dart';

import '../models/models.dart';
import 'data_card.dart';

final userCredential = FirebaseAuth.instance;

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

   @override
  _PrincipalPage createState() => _PrincipalPage();
    
}

class _PrincipalPage extends State<PrincipalPage> {
  
  @override
  void initState()   {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
                height: 250,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/43/bc/57/43bc573f4dae2ad70361e7113db688cb.jpg'))),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, ${userCredential.currentUser?.displayName}',
                        style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black),
                      ),
                      const Text(
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
              padding: EdgeInsets.only(top: 130),
              height: MediaQuery.of(context).size.height * 1.2,
              width: double.infinity,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 35, left: 35),
                        child: const Text(
                          'Recomendados',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 25),
                          child: Column(
                            children: [
                              CarouselSlider(
                                  items: imgList
                                      .map((item) => Container(
                                            child: Center(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                  child: Image.network(
                                                    item,
                                                    width: 1000,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ))
                                      .toList(),
                                  options: CarouselOptions(
                                      autoPlay: true,
                                      aspectRatio: 2.0,
                                      enlargeCenterPage: true))
                            ],
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 35, left: 35),
                        child: const Text(
                          'Populares',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 20,
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

                                    cardItem()
                                       /* cardItem(
                                        'https://i.pinimg.com/564x/73/35/34/73353454e5844ea81ce617517931f1c4.jpg'),
                                    SizedBox(width: 12),
                                    cardItem(
                                        'https://i.pinimg.com/564x/7f/ab/25/7fab256cb01b1c9a23c5a18c0c0d205c.jpg'),
                                    SizedBox(width: 12),
                                    cardItem(
                                        'https://i.pinimg.com/564x/31/64/3a/31643ade701bc5b8c8246c3f8410961b.jpg'),
                                    SizedBox(width: 12),
                                    cardItem(
                                        'https://i.pinimg.com/564x/0c/d7/73/0cd773d7ba87cc5ae268c21c1635500c.jpg')  */
                                  ],
                                ),
                              )))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }


final List<String> imgList = [
  'https://i.pinimg.com/564x/2b/4a/ad/2b4aadfae1577b27da41adc8c5d76e1e.jpg',
  'https://i.pinimg.com/564x/56/cb/61/56cb61b60c3a9c9bf7aba8966afa04fe.jpg',
  'https://i.pinimg.com/564x/14/73/0d/14730dee66f62a4daef72268c47ee629.jpg',
  'https://i.pinimg.com/564x/10/7a/d2/107ad2c677a14e62f167f9a82269bad6.jpg'
];
}