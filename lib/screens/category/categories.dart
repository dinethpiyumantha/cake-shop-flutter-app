import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../images/images.dart';
import 'edit.dart';

class Category {
  final String id;
  final String categoryType;
  final String description;

  Category({
    required this.id,
    required this.categoryType,
    required this.description,
  });
}

Future<List<Map<String, String>>> fetchCategories() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();

  final List<Map<String, String>> categories = [];

  for (final DocumentSnapshot<Map<String, dynamic>> documentSnapshot
      in querySnapshot.docs) {
    final Map<String, String> category = {
      "id": documentSnapshot.id,
      "categoryType": documentSnapshot.data()!['categoryType'] as String,
      "description": documentSnapshot.data()!['description'] as String,
    };

    categories.add(category);
  }

  return categories;
}

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Map<String, String>> sampleData = [
    {
      "id": "mdg2XFOZZpDrJsIM0N3k",
      "categoryType": "Card 1",
      "description": "Subtitle 1"
    },
  ];

  void loadCategories() async {
    final categories = await fetchCategories();
    setState(() {
      sampleData = categories;
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
            Navigator.pushNamed(context, "/categoriesAdd");
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.add_to_queue_sharp,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: null,
          title: const Text(
            'Categories',
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
                startColor: Colors.black87,
                endColor: Colors.black,
                category: sampleData[index],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      sampleData[index]['categoryType']!.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.deepOrange,
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
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cake),
              label: 'Recipies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: 0,
          onTap: (i) {},
        ),
      ),
    );
  }
}

// Card
class GradientCard extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Widget child;
  final Map<String, dynamic> category;

  GradientCard({
    required this.startColor,
    required this.endColor,
    required this.child,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(
              category: this.category,
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
              bottomRight: Radius.circular(40.0),
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(40.0)),
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
