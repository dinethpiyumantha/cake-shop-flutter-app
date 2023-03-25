import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class NewRecipeForm extends StatefulWidget {
  @override
  _NewRecipeFormState createState() => _NewRecipeFormState();
}

class _NewRecipeFormState extends State<NewRecipeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recipeTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
          'Add New Recipe',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _recipeTypeController,
                  decoration:
                      CustomFormStyles.formTextFieldStyle('Recipe Type'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a recipe type';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                      CustomFormStyles.formTextFieldStyle('Description'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      FirebaseFirestore.instance.collection('recipies').add({
                        'recipeType': _recipeTypeController.text,
                        'description': _descriptionController.text,
                      }).then((value) {
                        Navigator.pushNamed(context, '/recipies');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Recipe created')));
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Save'.toUpperCase()),
                  ),
                  style: CustomFormStyles.buttonStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
