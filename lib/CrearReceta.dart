import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Recetas.dart';

class CrearReceta extends StatefulWidget {
  const CrearReceta({super.key, required this.onRecipeAdded});

  final Function(Receta? reciper) onRecipeAdded;

  @override
  State<CrearReceta> createState() => _CrearRecetaState();
}

class _CrearRecetaState extends State<CrearReceta> {
  TextEditingController _recipeNameController = TextEditingController();
  TextEditingController _recipeDescriptionController = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  void registrarReceta() async {
    try {
      await firebase.collection('Recetas').doc().set(
        {
          "Email": _recipeNameController.text,
          "Password": _recipeDescriptionController.text,
        },
      );
    } catch (e) {
      print("Error" + e.toString());
    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _recipeNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _recipeDescriptionController,
                maxLines: 5, // Ajusta el número de líneas según tus necesidades
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Description',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if(_recipeNameController.text.isNotEmpty && _recipeDescriptionController.text.isNotEmpty){
                    registrarReceta();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Recetas()),
                    );
                  }else{
                    mostrarAlerta(context, "El nombre o descripcion no pueden estar vacios");
                  }

                },
                child: const Text('Add Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
