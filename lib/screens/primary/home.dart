import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        body: ListView(
            // Set the background color of the container

            children: <Widget>[
              // Add list items here
              SizedBox(
                height: 20,
              ),

              CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.tHazKOANlqgLg10n1sF_dgHaLH?w=185&h=278&c=7&r=0&o=5&pid=1.7"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.DaVxeM7HxPNxQmdnWnV3GgHaJ6?w=185&h=248&c=7&r=0&o=5&pid=1.7"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //3rd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.yNlcG6TzEcgNH1q9rqgvFwHaLw?w=185&h=294&c=7&r=0&o=5&pid=1.7"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //4th Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.bf85okw0osmlll4lrBi4VAHaLT?w=185&h=282&c=7&r=0&o=5&pid=1.7"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //5th Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.nJY46DzJNvqtT1qOIJLgrwHaJQ?w=185&h=231&c=7&r=0&o=5&pid=1.7"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              SizedBox(height: 20),
              Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 252, 229, 229),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              //fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing"
                          "and typesetting industry. Lorem Ipsum has been the"
                          "indu stry's standard dummy text ever since the"
                          "1500s, whe an unknown printer took a galley of type"
                          "and sc rambled it to make a type printer took a...",
                          style: TextStyle(
                              height: 1.3,
                              //fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 13,
                              color: Colors.grey[900]),
                        ),
                      ])),
            ]),
        bottomNavigationBar: Navigations.BottomBarNavigate(context, 0));
  }
}
