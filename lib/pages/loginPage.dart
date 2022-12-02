import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pois/pages/poiListPage.dart';
import 'package:pois/pages/poiPage.dart';
import 'package:pois/pages/registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Icon(Icons.home, size: 200),
    );

    final email = TextFormField(
      controller: _emailTextController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Correo electrónico',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordTextController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 66, 66, 66),
        ),
        onPressed: () async {
          try {
            final credential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text);

            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PoiListPage()));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
        },
        child:
            const Text('Iniciar sesion', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Registarse',
        style: TextStyle(color: Color.fromARGB(255, 3, 0, 189)),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterPage()));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
