import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Recetas.dart';

class CrearReceta extends StatefulWidget {
  @override
  State<CrearReceta> createState() => _CrearRecetaState();
}

class _CrearRecetaState extends State<CrearReceta> {
  TextEditingController _recipeNameController = TextEditingController();
  TextEditingController _recipeDescriptionController = TextEditingController();
  String _selectedCategory = 'Pizza';
  final firebase = FirebaseFirestore.instance;

  void createRecipe() async {
    try {
      await firebase.collection('Recetas').doc().set(
        {
          "Nombre": _recipeNameController.text,
          "Descripcion": _recipeDescriptionController.text,
          "Categoria": _selectedCategory,
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
                Navigator.of(context).pop();
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
        title: const Text('Crear receta'),
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
                  labelText: 'Nombre de la receta',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _recipeDescriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripción de la receta',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: <String>['Pizza', 'Pasta', 'Ensalada','Sopa','Postre','Aperitivo','Otro']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (_recipeNameController.text.isNotEmpty &&
                      _recipeDescriptionController.text.isNotEmpty) {
                    createRecipe();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Recetas()),
                    );
                  } else {
                    mostrarAlerta(
                        context, "El nombre o descripción no pueden estar vacíos");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Crear Receta',
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
