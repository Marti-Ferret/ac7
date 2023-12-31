import 'package:ac7test/my_app.dart';
import 'package:ac7test/recipe_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Controller_Shared.dart';
import 'CrearReceta.dart';

class Recetas extends StatefulWidget {
  @override
  _RecetasState createState() => _RecetasState();
}

class _RecetasState extends State<Recetas> {
  final firebase = FirebaseFirestore.instance;
  late Future<List<Recipe>> recipesFuture;

  late Controller_Shared controller_shared;


  @override
  void initState(){
    super.initState();
    controller_shared = Controller_Shared();
    controller_shared.initialize();
    recipesFuture = getRecipes();
  }

  Future<List<Recipe>> getRecipes() async {
    List<Recipe> recipes = [];

    try {
      final QuerySnapshot querySnapshot =
          await firebase.collection("Recetas").get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final name = data["Nombre"];
        final description = data["Descripcion"];
        final tipo = data["Categoria"];
        final creator = data["Creador"];

        recipes.add(Recipe(
            name: name,
            description: description,
            type: tipo,
            creator: creator));
      }
    } catch (e) {
      print("Error getting documents: $e");
    }

    return recipes;
  }

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

  void _showRecipeDetails(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsPage(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getRecipes();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recetas',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await controller_shared.deleteShared('email');

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginApp()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.lightBlue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearReceta()),
              );
            },
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: recipesFuture,
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              List<Recipe> recipes = snapshot.data ?? [];

              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: recipes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              _showRecipeDetails(recipes[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 18.0 / 11.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        getImagePath(recipes[index].type),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          recipes[index].name,
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class Recipe {
  final String name;
  final String description;
  final String type;
  final String creator;

  const Recipe(
      {required this.name,
      required this.description,
      required this.type,
      required this.creator});
}
