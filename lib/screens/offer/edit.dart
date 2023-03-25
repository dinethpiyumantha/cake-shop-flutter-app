import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class OfferDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> offer;

  OfferDetailsScreen({required this.offer});

  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _offerTypeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _offerTypeController =
        TextEditingController(text: widget.offer['offerType']);
    _descriptionController =
        TextEditingController(text: widget.offer['description']);
  }

  @override
  void dispose() {
    _offerTypeController.dispose();
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
          'Offer Details',
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
                controller: _offerTypeController,
                decoration: CustomFormStyles.formTextFieldStyle('Offer Type'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a offer type';
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
                        .collection('offers')
                        .doc(widget.offer['id'])
                        .update({
                      'offerType': _offerTypeController.text,
                      'description': _descriptionController.text,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Offer updated')));
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
                      .collection('offers')
                      .doc(widget.offer['id'])
                      .delete()
                      .then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Offer deleted')));
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
