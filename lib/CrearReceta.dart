import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Recetas.dart';

class CrearReceta extends StatefulWidget {
  const CrearReceta({super.key, required this.onRecipeAdded});

  final Function(Receta? reciper) onRecipeAdded;

  @override
  State<CrearReceta> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<CrearReceta> {
  TextEditingController _recipeNameController = TextEditingController();
  TextEditingController _recipeDescriptionController = TextEditingController();

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Description',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _saveRecipe();
                },
                child: const Text('Add Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveRecipe() {
    var name = _recipeNameController.text;
    var description = _recipeDescriptionController.text;
    if (name.isNotEmpty && description.isNotEmpty) {
      widget.onRecipeAdded(Receta(name: name, description: description));
      Navigator.pop(context);
      // Navigator.pop(context, Recipe(name: name, description: description));
    }
  }
}
