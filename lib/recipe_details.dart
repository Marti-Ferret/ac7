import 'package:flutter/material.dart';
import 'Recetas.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsPage({Key? key, required this.recipe}) : super(key: key);

  String getImagePath(String tipo) {
    switch (tipo) {
      case 'Pizza':
        return 'assets/images/pizza.jpg';
      case 'Pasta':
        return 'assets/images/pasta.jpg';
      case 'Aperitivo':
        return 'assets/images/aperitivo.jpg';
      case 'Ensalada':
        return 'assets/images/ensalada.jpg';
      case 'Otro':
        return 'assets/images/otro.jpg';
      case 'Postre':
        return 'assets/images/postre.jpg';
      case 'Sopa':
        return 'assets/images/sopa.jpg';
      default:
        return 'assets/images/otro.jpg';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(getImagePath(recipe.tipo)),
            SizedBox(height: 16.0),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(recipe.description, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}