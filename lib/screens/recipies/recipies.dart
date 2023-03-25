import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../images/images.dart';
import '../primary/navigations.dart';
import 'edit.dart';

class Recipe {
  final String id;
  final String recipeType;
  final String description;

  Recipe({
    required this.id,
    required this.recipeType,
    required this.description,
  });
}

Future<List<Map<String, String>>> fetchCategories() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('recipies').get();

  final List<Map<String, String>> recipies = [];

  for (final DocumentSnapshot<Map<String, dynamic>> documentSnapshot
      in querySnapshot.docs) {
    final Map<String, String> recipe = {
      "id": documentSnapshot.id,
      "recipeType": documentSnapshot.data()!['recipeType'] as String,
      "description": documentSnapshot.data()!['description'] as String,
    };

    recipies.add(recipe);
  }

  return recipies;
}

class RecipeScreen extends StatefulWidget {
  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<Map<String, String>> sampleData = [
    {
      "id": "mdg2XFOZZpDrJsIM0N3k",
      "recipeType": "Card 1",
      "description": "Subtitle 1"
    },
  ];

  void loadCategories() async {
    final recipies = await fetchCategories();
    setState(() {
      sampleData = recipies;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/recipiesAdd");
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: null,
          title: const Text(
            'Recipies',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: ListView.builder(
            itemCount: sampleData.length,
            itemBuilder: (context, index) {
              return GradientCard(
                startColor: Colors.pink,
                endColor: Colors.deepOrange,
                recipe: sampleData[index],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      sampleData[index]['recipeType']!.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      sampleData[index]['description']!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Navigations.BottomBarNavigate(context, 1),
      ),
    );
  }
}

// Card
class GradientCard extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Widget child;
  final Map<String, dynamic> recipe;

  GradientCard({
    required this.startColor,
    required this.endColor,
    required this.child,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipe: this.recipe,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // image: const DecorationImage(
          //   image: AssetImage(Images.CATEGORY_CARD_BG),
          //   fit: BoxFit.cover,
          // ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(7.0),
              bottomRight: Radius.circular(7.0),
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: child,
      ),
    );
  }
}
