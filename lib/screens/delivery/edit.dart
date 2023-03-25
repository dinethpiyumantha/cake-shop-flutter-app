import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> delivery;

  DeliveryDetailsScreen({required this.delivery});

  @override
  _DeliveryDetailsScreenState createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _deliveryTypeController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _deliveryTypeController =
        TextEditingController(text: widget.delivery['deliveryType']);
    _addressController =
        TextEditingController(text: widget.delivery['address']);
  }

  @override
  void dispose() {
    _deliveryTypeController.dispose();
    _addressController.dispose();
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
          'Delivery Details',
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
                controller: _deliveryTypeController,
                decoration:
                    CustomFormStyles.formTextFieldStyle('Delivery Type'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a delivery type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: CustomFormStyles.formTextFieldStyle('Address'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FirebaseFirestore.instance
                        .collection('deliveries')
                        .doc(widget.delivery['id'])
                        .update({
                      'deliveryType': _deliveryTypeController.text,
                      'address': _addressController.text,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Delivery updated')));
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
                      .collection('deliveries')
                      .doc(widget.delivery['id'])
                      .delete()
                      .then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Delivery deleted')));
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
