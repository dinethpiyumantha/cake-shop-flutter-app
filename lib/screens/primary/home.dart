import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nature Nest Cakes',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          ElevatedButton(
            onPressed: () {
              //Use this to Log Out user
              FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: Colors.black,
            ),
            child: Text('Sign Out'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: SizedBox()),
      ),
      bottomNavigationBar: Navigations.BottomBarNavigate(context, 0),
    );
  }
}
