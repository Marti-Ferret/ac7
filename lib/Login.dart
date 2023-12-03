import 'package:ac7test/Controller_Shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Recetas.dart';
import 'Registro.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  late Controller_Shared controller_shared;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-login-credentials") {
        showAlert(context, 'Contraseña o email incorrecto');
      } else if (e.code == "invalid-email") {
        showAlert(context, 'Email invalido');
      } else if (e.code == "missing-password") {
        showAlert(context, 'Contraseña incorrecta');
      }
      return false;
    }
  }

  void showAlert(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
  Future<void> checkLogin() async {
    String? email = await controller_shared.getShared('email');
    print("EMAIL: $email");
    if (email != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Recetas()),
      );
    }
  }




  @override
  void initState() {
    super.initState();
    initialize();
  }


  Future<void> initialize() async {
    await Firebase.initializeApp();
    controller_shared = Controller_Shared();
    await controller_shared.initialize();
    checkLogin();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido a la app de recetas',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(50.0),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 100.0,
                  color: Colors
                      .blue, // Puedes ajustar el color según tus preferencias
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange,
                      Colors.orangeAccent,
                    ], // Colores del degradado
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _emailController,
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Introce tu email',
                      filled: true,
                      fillColor: Colors.transparent,
                      // Establecer como transparente para ver el degradado de fondo
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15.0), // Ajusta el margen aquí
                        child: Icon(Icons.email), // Añadir el icono a la izquierda con margen
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Ajusta el margen general
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange,
                      Colors.orangeAccent,
                    ], // Colores del degradado
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Introduce tu contraseña',
                      filled: true,
                      fillColor: Colors.transparent,
                      // Establecer como transparente para ver el degradado de fondo
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15.0), // Ajusta el margen aquí
                        child: Icon(Icons.lock), // Añadir el icono a la izquierda con margen
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Ajusta el margen general
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue,
                      Colors.lightBlue
                    ], // Degradado de azul claro a azul oscuro
                  ),
                  borderRadius: BorderRadius.circular(20.0),

                ),
                height: 45.0,
                child: ElevatedButton(
                  onPressed: () async {
                    controller_shared.saveShared('email', _emailController.text);
                    if (await signIn()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Recetas()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.transparent, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    elevation: 2.0,
                    side: const BorderSide(color: Colors.white),
                    textStyle: const TextStyle(fontSize: 20.0),
                  ),
                  child: const Text('Acceder'),
                ),
              ),
              // Texto adicional como botón
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                child: const Text(
                  "¿Aún no tienes cuenta? Pulsa aquí",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
