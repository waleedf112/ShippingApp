import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database2_project_shipping_app/Customer/SendPackage.dart';

import 'SignupAndSignin.dart';

Stream getAllActiveShipments() {
  return Firestore.instance
      .collection('Shipments')
      .where('sender_userName', isEqualTo: currentUser.username)
      .snapshots();
}

placeNewShipment(Shipment shipment) async {
  String shipment_id = shipment.id.toString();
  String receiver_id = shipment.receiverId.toString();
  await Firestore.instance
      .collection('Shipments')
      .document(shipment_id)
      .setData({
    'shipment_id': shipment_id,
    'status': shipment.status,
    'carrier_userName': null,
    'registrationDate': shipment.registrationDate,
    'receiverId': shipment.receiverId,
    'senderCity': shipment.senderCity,
    'senderAddress': shipment.senderAddress,
    'sender_userName': currentUser.username
  });
  for (int i = 0; i < shipment.packages.length; i++) {
    await Firestore.instance.collection('Packages').document().setData({
      'customer_userName': currentUser.username,
      'height': shipment.packages[i].height,
      'width': shipment.packages[i].width,
      'depth': shipment.packages[i].depth,
      'weight': shipment.packages[i].weight,
      'cost': shipment.packages[i].cost,
      'shipment_id': shipment_id,
    });
  }

  await Firestore.instance
      .collection('Receivers')
      .document(receiver_id)
      .setData({
    'receiver_id': shipment.receiverId,
    'receiverName': shipment.receiverName,
    'receiverphone': shipment.receiverphone,
    'receiverCity': shipment.receiverCity,
    'receiverAddress': shipment.receiverAddress,
  });
}

Stream trackShipment(int trackingNumber) {
  print(trackingNumber);
  return Firestore.instance
      .collection('Shipments')
      .document(trackingNumber.toString())
      .snapshots();
}
