import 'package:flutter/material.dart';

import 'CrearReceta.dart';

class Recetas extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recetas',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CrearReceta(onRecipeAdded: (Receta? reciper) {  },
                  ),
                ),
              );
            },
          ),
          ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

    );
  }
}
class Receta {
  final String name;
  final String description;

  const Receta({required this.name, required this.description});
}

