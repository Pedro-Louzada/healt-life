import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutricao_app/pages/credits.dart';
import 'package:nutricao_app/pages/login_page.dart';
import '../components/principal_page.dart';
import '../components/sized_circle.dart';

class ProfileLogout extends StatefulWidget {
  const ProfileLogout({super.key});

  @override
  State<ProfileLogout> createState() => _ProfileLogoutState();
}

class _ProfileLogoutState extends State<ProfileLogout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedCircle(
            elevation: 4.0,
            child: Icon(
              Icons.person,
              size: 100.0,
              color: Colors.white,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: Text(
                '${userCredential.currentUser?.displayName}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, right: 90),
            child: ElevatedButton(
              onPressed: () {
                Future<void> _signOut() async {
                  await FirebaseAuth.instance.signOut();
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Desconectado com sucesso!')),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return const Color.fromARGB(156, 247, 151, 18);
                  }),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(20.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ))),
              child: const Text('Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Credito(),
                  ));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) {
                return Color.fromARGB(156, 247, 151, 18);
              }),
            ),
            child: const Text('Creditos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold)),
          ))
        ],
      ),
    );
  }
}
