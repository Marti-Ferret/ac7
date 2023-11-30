import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ac7test/my_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registro extends StatelessWidget {
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

  void mostrarAlerta(BuildContext context, String mensaje) {
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
        return false;
      } else if (e.code == "invalid-email") {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: Colors.yellow,
                      // Fondo circular azul
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      filled: true,
                      fillColor: Colors.yellow,
                      // Fondo circular azul
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      filled: true,
                      fillColor: Colors.yellow,
                      // Fondo circular azul
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (validarNuevoUsuario(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text) ==
                      0) {
                    if (await registerUser()) {
                      mostrarAlerta(context, 'Usuario creado');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginApp()),
                      );
                    }
                  } else if (validarNuevoUsuario(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text) ==
                      1) {
                    mostrarAlerta(context, 'Los campos no pueden estar vacios');
                  } else if (validarNuevoUsuario(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text) ==
                      2) {
                    mostrarAlerta(context, 'Este email ya esta registrado');
                  } else if (validarNuevoUsuario(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text) ==
                      3) {
                    mostrarAlerta(context, 'Las contraseÃ±as no coinciden');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Color azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
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