import 'dart:async';

import 'package:cake_shop/screens/category/categories.dart';
import 'package:cake_shop/screens/category/create.dart';
import 'package:cake_shop/screens/delivery/addresses.dart';
import 'package:cake_shop/screens/delivery/create.dart';
import 'package:cake_shop/screens/primary/home.dart';
import 'package:cake_shop/screens/recipies/create.dart';
import 'package:cake_shop/screens/recipies/recipies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './auth/auth.dart';
import 'images/images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDickbgiBslWo5gmr0S1TCBqxQtN-yIOqo",
      authDomain: "ctse-lab-4-c45df.firebaseapp.com",
      projectId: "ctse-lab-4-c45df",
      storageBucket: "ctse-lab-4-c45df.appspot.com",
      messagingSenderId: "98501448039",
      appId: "1:98501448039:web:cc2fc49916995003239fc2",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        // '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/recipies': (context) => RecipeScreen(),
        '/deliveries': (context) => DeliveryScreen(),
        '/recipiesAdd': (context) => NewRecipeForm(),
        '/deliveriesAdd': (context) => NewDeliveryForm(),
        '/categories': (context) => CategoryScreen(),
        '/categoriesAdd': (context) => NewCategoryForm(),
      },
      // home: SplashScreen(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final bool _isLogin = true;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    setState(() => _loading = true);

    //Check if is login or register
    if (_isLogin) {
      await Auth().signInWithEmailAndPassword(email, password);
    } else {
      await Auth().registerWithEmailAndPassword(email, password);
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Form(
            //Add form to key to the Form Widget
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.LOGO,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  //Assign controller
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    focusColor: Colors.deepOrange,
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  //Assign controller
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () => handleSubmit(),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(_isLogin ? 'Login' : 'Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          Images.LOGO,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
