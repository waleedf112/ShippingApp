import 'package:cloud_firestore/cloud_firestore.dart';
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
          });
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
