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

Stream getReceiver(shipmentReceiver) {
  return Firestore.instance
      .collection('Receivers')
      .where('receiver_id', isEqualTo: shipmentReceiver)
      .snapshots();
}

Future getSender(shipmentSender) async {
  return Firestore.instance.collection('User').document(shipmentSender).get();
}

Future assignToShipment(shipment_id) async {
  await Firestore.instance
      .collection('Shipments')
      .document(shipment_id)
      .updateData({
    'carrier_userName': currentUser.username,
    'status': 'تم القبول من قبل ${currentUser.name}',
  });
  await Firestore.instance
      .collection('User')
      .document(currentUser.username)
      .updateData({
    'isBusy': true,
  });
}

Future updateStatus(shipment_id, message) async {
  await Firestore.instance
      .collection('Shipments')
      .document(shipment_id)
      .updateData({
    'status': message,
  });
}

Future delivered(shipment_id) async {
  await Firestore.instance
      .collection('Shipments')
      .document(shipment_id)
      .updateData({
    'carrier_userName': 'already delivered',
  });
  await Firestore.instance
      .collection('User')
      .document(currentUser.username)
      .updateData({
    'isBusy': false,
  });
}
