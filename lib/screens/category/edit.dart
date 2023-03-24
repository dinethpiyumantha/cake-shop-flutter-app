import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: Text('Category Details'),
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
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                    child: Text('Update'),
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
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
