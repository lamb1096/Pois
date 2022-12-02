import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pois/pages/loginPage.dart';
import 'package:pois/pages/poiListPage.dart';
import 'package:pois/pages/poiPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  var _password2TextController = TextEditingController();

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

    final rePassword = TextFormField(
      controller: _password2TextController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Repetir contraseña',
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
          if (_passwordTextController.text == _password2TextController.text) {
            try {
              final credential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _password2TextController.text,
              );

              await db.collection("usuarios").doc().set({
                "email": _emailTextController.text,
                "contraseña": _password2TextController.text
              }).onError((e, _) => print("Error writing document: $e"));

              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PoiListPage()));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          }
        },
        child: const Text('Registrar', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Iniciar sesion',
        style: TextStyle(color: Color.fromARGB(255, 3, 0, 189)),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
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
            const SizedBox(height: 8.0),
            rePassword,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
