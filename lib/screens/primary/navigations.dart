import 'package:flutter/material.dart';

class Navigations {
  static BottomBarNavigate(context, currentIndex) {
    return BottomNavigationBar(
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
      currentIndex: currentIndex,
      onTap: (i) {
        List<String> routes = [
          '/home',
          '/recipies',
          '/categories',
          '/favorites',
          '/profile'
        ];

        Navigator.pushNamed(context, routes[i]);
      },
    );
  }
}
