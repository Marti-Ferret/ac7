import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Recetas.dart';
import 'Registro.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
  bool usuarioExiste(String email, String password) {
    return users.any((user) => user['Email'] == email && user['Password'] == password);
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


  @override
  Widget build(BuildContext context) {
    cogerUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
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
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: Colors.yellow, // Fondo circular amarillo
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0), // Bordes circulares
                      ),
                      labelStyle: TextStyle(color: Colors.black), // Color de la etiqueta en negro
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
                      fillColor: Colors.yellow, // Fondo circular amarillo
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0), // Bordes circulares
                      ),
                      labelStyle: TextStyle(color: Colors.black), // Color de la etiqueta en negro
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if(usuarioExiste(_emailController.text, _passwordController.text)){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Recetas()),
                    );
                  }else{
                    mostrarAlerta(context, 'Usuario no registrado');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.yellow, // Color amarillo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              // Texto adicional como botón
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                },
                child: Text(
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