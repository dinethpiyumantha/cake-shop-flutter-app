import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> recipe;

  RecipeDetailsScreen({required this.recipe});

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _recipeTypeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _recipeTypeController =
        TextEditingController(text: widget.recipe['recipeType']);
    _descriptionController =
        TextEditingController(text: widget.recipe['description']);
  }

  @override
  void dispose() {
    _recipeTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: const Text(
          'Recipe Details',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _recipeTypeController,
                decoration: CustomFormStyles.formTextFieldStyle('Recipe Type'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a recipe type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: CustomFormStyles.formTextFieldStyle('Description'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FirebaseFirestore.instance
                        .collection('recipies')
                        .doc(widget.recipe['id'])
                        .update({
                      'recipeType': _recipeTypeController.text,
                      'description': _descriptionController.text,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Recipe updated')));
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Update'.toUpperCase()),
                ),
                style: CustomFormStyles.buttonStyle(),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('recipies')
                      .doc(widget.recipe['id'])
                      .delete()
                      .then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Recipe deleted')));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Delete'.toUpperCase()),
                ),
                style: CustomFormStyles.buttonStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
