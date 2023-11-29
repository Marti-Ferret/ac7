import 'dart:js';
import 'dart:js_interop';
import 'package:flutter/material.dart';


import 'package:ac7test/my_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


class Registro extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  List<Map<String, dynamic>> users = [];

  void cogerUsuarios() async {
    try {
      final QuerySnapshot querySnapshot = await firebase.collection("Usuarios").get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        users.add(data);
      }
    } catch (e) {
      print("Error getting documents: $e");
    }
  }
  bool usuarioExiste(String email){

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
          title: Text('Alerta'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la alerta
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void registrarUsuario() async{
  try{
    await firebase.collection('Usuarios').doc().set(
      {
        "Email": _emailController.text,
        "Password": _passwordController.text
      }
    );
  }catch(e){
    print("Error"+e.toString());
  }
  }

  @override
  Widget build(BuildContext context) {
    cogerUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                      fillColor: Colors.yellow, // Fondo circular azul
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
                      fillColor: Colors.yellow, // Fondo circular azul
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
                      fillColor: Colors.yellow, // Fondo circular azul
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
              ElevatedButton(
                onPressed: () {

                  if (_passwordController.text == _confirmPasswordController.text) {

                    if(!usuarioExiste(_emailController.text)){
                      mostrarAlerta(context, 'Usuario creado');
                      registrarUsuario();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginApp()),
                      );
                    }else{
                      mostrarAlerta(context, 'Este email ya esta registrado, usuario no creado');
                    }

                  } else {
                    mostrarAlerta(context, 'Las contraseñas no coinciden');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Color azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
