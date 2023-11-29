import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Recetas.dart';
import 'Registro.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    controller: _usernameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter your username',
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
                  if(_usernameController.text == 'a'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Recetas()),
                    );
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
