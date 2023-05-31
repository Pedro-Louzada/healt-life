import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddFoods extends StatefulWidget {
  const AddFoods({super.key});

  @override
  State<AddFoods> createState() => _AddFoodsState();
}

class _AddFoodsState extends State<AddFoods> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    nomeController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Color.fromRGBO(255, 209, 143, 100),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          child: Container(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    'Crie seu cardápio de refeições',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(255, 209, 143, 100)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Digite seu nome completo',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color.fromRGBO(255, 209, 143, 100),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Digite seu email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Color.fromRGBO(255, 209, 143, 100),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Digite sua senha',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Color.fromRGBO(255, 209, 143, 100),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final nome = nomeController.text;
                    final email = emailController.text;
                    final password = passwordController.text;

                    try {
                      final userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password);
                      print(userCredential);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuário registrado!')),
                      );
                      _firestore.collection('usuario').add({
                        'nomeUsuario': nome,
                        'email': email,
                      }).then((DocumentReference doc) {
                        print('Usuario salvo com ID: ${doc.id}');
                      }).catchError((error) {
                        print('Erro ao salvar usuário: $error');
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Senha fraca')),
                        );
                      }
                      if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email já cadastrado')),
                        );
                      }
                      if (e.code == 'invalid-email') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('email invalido')),
                        );
                      }
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
          ))),
    );
  }
}


// 


// ListView(
//             children: [
//               SizedBox(
//                 width: 150,
//                 height: 150,
//                 child: Image.asset('assets/Logo-Nutri.png'),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Center(
//                   child: Text(
//                     'Criar sua conta',
//                     style: TextStyle(
//                         fontSize: 28,
//                         color: Colors.white,
//                         fontFamily: 'OpenSans'),
//                   ),
//                 ),
//               ),
//               TextFormField(
//                 style: const TextStyle(color: Colors.white, fontSize: 18),
//                 controller: nomeController,
//                 decoration: InputDecoration(
//                   labelText: 'Nome',
//                   labelStyle: TextStyle(color: Colors.white),
//                   hintText: 'Digite seu nome completo',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                   prefixIcon: Icon(Icons.person),
//                   prefixIconColor: Color.fromARGB(255, 209, 143, 100),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: emailController,
//                 enableSuggestions: false,
//                 autocorrect: false,
//                 keyboardType: TextInputType.emailAddress,
//                 style: const TextStyle(color: Colors.white, fontSize: 18),
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: TextStyle(color: Colors.white),
//                   hintText: 'Digite seu email',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                   prefixIcon: Icon(Icons.person),
//                   prefixIconColor: Color.fromARGB(255, 209, 143, 100),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: true,
//                 enableSuggestions: false,
//                 autocorrect: false,
//                 style: const TextStyle(color: Colors.white, fontSize: 18),
//                 decoration: InputDecoration(
//                   labelText: 'Senha',
//                   labelStyle: TextStyle(color: Colors.white),
//                   hintText: 'Digite sua senha',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0)),
//                   hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
//                   prefixIcon: Icon(Icons.person),
//                   prefixIconColor: Color.fromARGB(255, 209, 143, 100),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final nome = nomeController.text;
//                   final email = emailController.text;
//                   final password = passwordController.text;

//                   try {
//                     final userCredential = await FirebaseAuth.instance
//                         .createUserWithEmailAndPassword(
//                             email: email, password: password);
//                     print(userCredential);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Usuário registrado!')),
//                     );
//                     _firestore.collection('usuario').add({
//                       'nomeUsuario': nome,
//                       'email': email,
//                     }).then((DocumentReference doc) {
//                       print('Usuario salvo com ID: ${doc.id}');
//                     }).catchError((error) {
//                       print('Erro ao salvar usuário: $error');
//                     });
//                   } on FirebaseAuthException catch (e) {
//                     if (e.code == 'weak-password') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Senha fraca')),
//                       );
//                     }
//                     if (e.code == 'email-already-in-use') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Email já cadastrado')),
//                       );
//                     }
//                     if (e.code == 'invalid-email') {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('email invalido')),
//                       );
//                     }
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateColor.resolveWith((states) {
//                     return Color.fromRGBO(255, 209, 143, 100);
//                   }),
//                   padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
//                 ),
//                 child: const Text('Cadastrar',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontFamily: 'OpenSans')),
//               ),
//             ],
//           ),