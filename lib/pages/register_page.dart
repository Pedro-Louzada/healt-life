import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/dbController.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController dtNascimentoController = TextEditingController();

  @override
  void initState() {
    nomeController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fotoController = TextEditingController();
    dtNascimentoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fotoController.dispose();
    dtNascimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFDB9666),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/Logo-Nutri.png'),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white),
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
                TextFormField(
                  controller: fotoController,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Foto',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'URL da foto',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    prefixIcon: Icon(Icons.photo),
                    prefixIconColor: Color.fromRGBO(255, 209, 143, 100),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dtNascimentoController,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'xx/xx/xxxx',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    prefixIcon: Icon(Icons.date_range),
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
                    final foto = fotoController.text;
                    final dtNascimento = dtNascimentoController.text;

                    try {
                      final userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password);
                      userCredential.user?.updateDisplayName(nome);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuário registrado!')),
                      );
                      Navigator.pop(context);
                      Database.insertUsuario(nome, foto, dtNascimento);
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
                  child: const Text('Cadastrar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OpenSans')),
                ),
              ],
            ),
          ))),
    );
  }
}
