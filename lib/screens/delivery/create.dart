import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class NewDeliveryForm extends StatefulWidget {
  @override
  _NewDeliveryFormState createState() => _NewDeliveryFormState();
}

class _NewDeliveryFormState extends State<NewDeliveryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _deliveryTypeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
          'Add New Delivery',
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
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      FirebaseFirestore.instance.collection('deliveries').add({
                        'deliveryType': _deliveryTypeController.text,
                        'address': _addressController.text,
                      }).then((value) {
                        Navigator.pushNamed(context, '/deliveries');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Delivery created')));
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
