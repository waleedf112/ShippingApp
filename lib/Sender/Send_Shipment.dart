import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SenderScreen extends StatefulWidget {
  @override
  _SenderScreenState createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  List list = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شحنة جديدة'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.local_shipping),
            iconSize: 28,
            onPressed: () async {
              await Firestore.instance.collection('Shipment').add({
                'Status': [],
                'Carrier_id': null,
                'RegistrationDate': DateTime.now(),
                'Packages': [],
                'Receiver_id': 0
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            iconSize: 28,
            onPressed: () => setState(() {
              list.add('');
            }),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return _PackageWidget();
        },
      ),
    );
  }
}

class _PackageWidget extends StatefulWidget {
  @override
  __PackageWidgetState createState() => __PackageWidgetState();
}

class __PackageWidgetState extends State<_PackageWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: FlutterLogo(
        size: 90,
      ),
    );
  }
}
