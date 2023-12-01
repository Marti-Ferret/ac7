import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<String?> findRecipeId(String recipeName, String description, String type) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Recetas')
          .where('Nombre', isEqualTo: recipeName)
          .where('Descripcion', isEqualTo: description)
          .where('Categoria', isEqualTo: type)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Devuelve el ID del primer documento coincidente
        return querySnapshot.docs.first.id;
      } else {
        print('No se encontró la receta con los valores proporcionados');
        return null;
      }
    } catch (e) {
      print('Error al buscar el ID de la receta: $e');
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await FirebaseFirestore.instance.collection('Recetas').doc(recipeId).delete();
      print('Receta eliminada correctamente');
    } catch (e) {
      print('Error al eliminar la receta: $e');
      // Puedes manejar el error de alguna manera, por ejemplo, mostrando un mensaje al usuario
    }
  }

  Future<String?> getCurrentEmail() async {
    User? user = await getCurrentUser();
    return user?.email;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          // Agrega un icono de eliminación en la esquina superior derecha
          FutureBuilder<String?>(
            future: getCurrentEmail(),
            builder: (context, snapshot) {

                if (snapshot.hasData && recipe.creator == snapshot.data) {
                  return IconButton(
                    onPressed: () async {
                      String? id = await findRecipeId(recipe.name,recipe.description,recipe.type);
                      await deleteRecipe(id!);
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Recetas()),
                      );
                    },
                  icon: Icon(Icons.delete),
                  );
                } else {
                  return Container();
                }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(getImagePath(recipe.type)),
            SizedBox(height: 16.0),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(recipe.description, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            Text(
              'Creador:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(recipe.creator, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
  }