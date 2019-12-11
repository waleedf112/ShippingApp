import 'package:cloud_firestore/cloud_firestore.dart';

import 'SignupAndSignin.dart';

getAllActiveOrders() {
  return Firestore.instance
      .collection('Orders')
      .where('user', isEqualTo: currentUser.username)
      .getDocuments()
      .asStream();
}
