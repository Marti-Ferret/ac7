import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ac7test/my_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Recetas.dart';


class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  List<Map<String, dynamic>> users = [];




  void cogerUsuarios() async {
    try {
      final QuerySnapshot querySnapshot =
      await firebase.collection("Usuarios").get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        users.add(data);
      }
    } catch (e) {
      print("Error getting documents: $e");
    }
  }

  bool usuarioExiste(String email) {
    if (users.any((user) => user['Email'] == email)) {
      return true;
    }

    return false;
  }

  void showAlert(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la alerta
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  int validarNuevoUsuario(
      String email, String password, String validatePassword) {
    if (_passwordController.text.isEmpty || _emailController.text.isEmpty) {
      return 1;
    } else {
      if (_passwordController.text == _confirmPasswordController.text) {
        if (!usuarioExiste(_emailController.text)) {
          return 0;
        } else {
          return 2;
        }
      } else {
        return 3;
      }
    }
  }

  Future<bool> registerUser() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-login-credentials") {
        showAlert(context, "mensaje");
        return false;
      }else if (e.code == "invalid-email") {
        showAlert(context, "Email invalido");
        return false;
      }else if (e.code == "missing-password") {
        showAlert(context, "Contraseña incorrecta");
        return false;
      } else if (e.code == "email-already-in-use") {
        showAlert(context, "Este email ya esta registrado");
        return false;
      }else if (e.code == "weak-password") {
        showAlert(context, "Contraseña debil");
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    cogerUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'CREAR CUENTA',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
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
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: Colors.transparent,
                      // Fondo circular azul
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
                      hintText: 'Enter your password',
                      filled: true,
                      fillColor: Colors.transparent,
                      // Fondo circular azul
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
                    controller: _confirmPasswordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      filled: true,
                      fillColor: Colors.transparent,
                      // Fondo circular azul
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
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    int resultado = validarNuevoUsuario(
                        _emailController.text,
                        _passwordController.text,
                        _confirmPasswordController.text);
                    if (resultado == 0) {
                      bool registrado = await registerUser();
                      if (registrado) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Recetas()),
                        );
                      }
                    } else if (resultado == 1) {
                      showAlert(context, "El email o la contraseña no pueden estar vacíos");
                    } else if (resultado == 2) {
                      showAlert(context, "Este email ya esta registrado");
                    } else if (resultado == 3) {
                      showAlert(context, "Las contraseñas no coinciden");
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
                  child: const Text('Registro'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}