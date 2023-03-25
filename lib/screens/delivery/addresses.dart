import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../images/images.dart';
import '../primary/navigations.dart';
import 'edit.dart';

class Delivery {
  final String id;
  final String deliveryType;
  final String address;

  Delivery({
    required this.id,
    required this.deliveryType,
    required this.address,
  });
}

Future<List<Map<String, String>>> fetchCategories() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('deliveries').get();

  final List<Map<String, String>> deliveries = [];

  for (final DocumentSnapshot<Map<String, dynamic>> documentSnapshot
      in querySnapshot.docs) {
    final Map<String, String> delivery = {
      "id": documentSnapshot.id,
      "deliveryType": documentSnapshot.data()!['deliveryType'] as String,
      "address": documentSnapshot.data()!['address'] as String,
    };

    deliveries.add(delivery);
  }

  return deliveries;
}

class DeliveryScreen extends StatefulWidget {
  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List<Map<String, String>> sampleData = [
    {
      "id": "mdg2XFOZZpDrJsIM0N3k",
      "deliveryType": "Card 1",
      "address": "Subtitle 1"
    },
  ];

  void loadCategories() async {
    final deliveries = await fetchCategories();
    setState(() {
      sampleData = deliveries;
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
            Navigator.pushNamed(context, "/deliveriesAdd");
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
            'Deliveries',
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
                startColor: Colors.white,
                endColor: Colors.white,
                delivery: sampleData[index],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sampleData[index]['deliveryType']!.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      sampleData[index]['address']!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Navigations.BottomBarNavigate(context, 3),
      ),
    );
  }
}

// Card
class GradientCard extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Widget child;
  final Map<String, dynamic> delivery;

  GradientCard({
    required this.startColor,
    required this.endColor,
    required this.child,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryDetailsScreen(
              delivery: this.delivery,
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
