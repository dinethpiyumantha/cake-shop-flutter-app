import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget_styles/form_styles.dart';

class NewOfferForm extends StatefulWidget {
  @override
  _NewOfferFormState createState() => _NewOfferFormState();
}

class _NewOfferFormState extends State<NewOfferForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _offerTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
          'Add New Offer',
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
                  controller: _offerTypeController,
                  decoration: CustomFormStyles.formTextFieldStyle('Offer Type'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a offer type';
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
                      FirebaseFirestore.instance.collection('offers').add({
                        'offerType': _offerTypeController.text,
                        'description': _descriptionController.text,
                      }).then((value) {
                        Navigator.pushNamed(context, '/offers');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Offer created')));
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
