import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  CategoryDetailsScreen({required this.category});

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _categoryTypeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _categoryTypeController =
        TextEditingController(text: widget.category['categoryType']);
    _descriptionController =
        TextEditingController(text: widget.category['description']);
  }

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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: const Text(
          'Category Details',
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
                controller: _categoryTypeController,
                decoration:
                    CustomFormStyles.formTextFieldStyle('Category Type'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a category type';
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
                        .collection('categories')
                        .doc(widget.category['id'])
                        .update({
                      'categoryType': _categoryTypeController.text,
                      'description': _descriptionController.text,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Category updated')));
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
                      .collection('categories')
                      .doc(widget.category['id'])
                      .delete()
                      .then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Category deleted')));
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
