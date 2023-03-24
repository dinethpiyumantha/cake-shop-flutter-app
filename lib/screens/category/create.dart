import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewCategoryForm extends StatefulWidget {
  @override
  _NewCategoryFormState createState() => _NewCategoryFormState();
}

class _NewCategoryFormState extends State<NewCategoryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _categoryTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _categoryTypeController,
                decoration: InputDecoration(
                  labelText: 'Category Type',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a category type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FirebaseFirestore.instance.collection('categories').add({
                      'categoryType': _categoryTypeController.text,
                      'description': _descriptionController.text,
                    }).then((value) {
                      Navigator.pushNamed(context, '/categories');
                    });
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
