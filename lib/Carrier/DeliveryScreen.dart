import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('توصيل شحنات'),
      ),
      body: StreamBuilder(
        stream:
            Firestore.instance.collection('Shipment').getDocuments().asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return _Package();
              },
            );
          }
          return FlutterLogo();
        },
      ),
    );
  }
}

class _Package extends StatefulWidget {
  @override
  __PackageState createState() => __PackageState();
}

class __PackageState extends State<_Package> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: FlutterLogo(
        size: 80,
      ),
    );
  }
}
