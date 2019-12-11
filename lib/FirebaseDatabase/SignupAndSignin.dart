import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database2_project_shipping_app/Carrier/Carrier.dart';
import 'package:database2_project_shipping_app/Customer/Customer.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class User {
  String username;
  String type;

  User({this.username, this.type});

  User.updateDB() {
    Firestore.instance.collection('User').document(this.username).updateData({
      'username': this.username,
      'type': this.type,
    });
  }
}

User currentUser;
Future<bool> registerUser(context, Map<String, String> userData) async {
  bool userExist = false;
  return loadingScreen(
      context: context,
      function: () async {
        await Firestore.instance
            .collection('User')
            .document(userData['username'])
            .get()
            .then((onValue) {
          if (onValue.exists) userExist = true;
        });
        if (!userExist) {
          await Firestore.instance
              .collection('User')
              .document(userData['username'])
              .setData({
            'username': userData['username'],
            'password': userData['password'],
            'type': null
          });
          currentUser = new User(
            username: userData['username'],
            type: null,
          );
        }
        Navigator.of(context).pop(userExist);
      }).then((onValue) {
    return onValue;
  });
}

Future<bool> loginUser(context, Map<String, String> userData) async {
  bool successful = false;
  return loadingScreen(
      context: context,
      function: () async {
        await Firestore.instance
            .collection('User')
            .document(userData['username'])
            .get()
            .then((onValue) {
          if (onValue.exists &&
              onValue.data['password'] == userData['password']) {
            successful = true;
            currentUser = new User(
              username: onValue.data['username'],
              type: onValue.data['type'],
            );
          }
        });
        Navigator.of(context).pop(successful);
      }).then((onValue) {
    return onValue;
  });
}

Future<void> assignType(BuildContext context, String type) {
  loadingScreen(
      context: context,
      function: () async {
        await Firestore.instance
            .collection('User')
            .document(currentUser.username)
            .updateData({
          'type': type,
        }).then((onValue) {
          Navigator.of(context).pop();
        });
      }).whenComplete((){
 if (type == 'Carrier') {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CarrierScreen()),
    );
  } else if (type == 'Customer') {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CustomerScreen()),
    );
  }
      });
 
}
