import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../images/images.dart';
import '../primary/navigations.dart';
import 'edit.dart';

class Offer {
  final String id;
  final String offerType;
  final String description;

  Offer({
    required this.id,
    required this.offerType,
    required this.description,
  });
}

Future<List<Map<String, String>>> fetchOffers() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('offers').get();

  final List<Map<String, String>> offers = [];

  for (final DocumentSnapshot<Map<String, dynamic>> documentSnapshot
      in querySnapshot.docs) {
    final Map<String, String> offer = {
      "id": documentSnapshot.id,
      "offerType": documentSnapshot.data()!['offerType'] as String,
      "description": documentSnapshot.data()!['description'] as String,
    };

    offers.add(offer);
  }

  return offers;
}

class OfferScreen extends StatefulWidget {
  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  List<Map<String, String>> sampleData = [
    {
      "id": "mdg2XFOZZpDrJsIM0N3k",
      "offerType": "Card 1",
      "description": "Subtitle 1"
    },
  ];

  void loadOffers() async {
    final offers = await fetchOffers();
    setState(() {
      sampleData = offers;
    });
  }

  @override
  void initState() {
    super.initState();
    loadOffers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/offersAdd");
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
            'Offers',
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
                startColor: Colors.yellow,
                endColor: Colors.yellowAccent,
                offer: sampleData[index],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      sampleData[index]['offerType']!.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      sampleData[index]['description']!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Navigations.BottomBarNavigate(context, 4),
      ),
    );
  }
}

// Card
class GradientCard extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Widget child;
  final Map<String, dynamic> offer;

  GradientCard({
    required this.startColor,
    required this.endColor,
    required this.child,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfferDetailsScreen(
              offer: this.offer,
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
