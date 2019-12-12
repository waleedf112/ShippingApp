import 'package:cloud_firestore/cloud_firestore.dart';

import 'SignupAndSignin.dart';

Stream getAllAvailibleShipments() {
  return Firestore.instance
      .collection('Shipments')
      .where('carrier_userName', isNull: true)
      .snapshots();
}

Stream isBusy() {
  return Firestore.instance
      .collection('User')
      .document(currentUser.username)
      .snapshots();
}

Stream getActiveShipment() {
  return Firestore.instance
      .collection('Shipments')
      .where('carrier_userName', isEqualTo: currentUser.username)
      .snapshots();
}

Future getShipmentPrice(shipment_id) async {
  int price = 0;
  await Firestore.instance
      .collection('Packages')
      .where('shipment_id', isEqualTo: shipment_id)
      .getDocuments()
      .then((onValue) {
    onValue.documents.forEach((doc) {
      price += doc['cost'];
    });
  });
  return price;
}
