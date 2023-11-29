import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recetas',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: null, // Eliminar el AppBar completo
        body: LoginPage(),
      ),
    );
  }
}