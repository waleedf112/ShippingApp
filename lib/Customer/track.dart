import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/CustomerOrder.dart';
import 'package:flutter/material.dart';

class TrackShipment extends StatefulWidget {
  int trackingNumber = 0;
  TextEditingController trackingController = new TextEditingController();
  @override
  _TrackShipmentState createState() => _TrackShipmentState();
}

class _TrackShipmentState extends State<TrackShipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('تتبع شحنتك'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      if (widget.trackingController.text.trim().isNotEmpty) {
                        setState(() {
                          widget.trackingNumber =
                              int.parse(widget.trackingController.text.trim());
                        });
                      }
                    },
                    icon:
                        Icon(Icons.check_circle, size: 30, color: Colors.white),
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: widget.trackingController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.near_me,
                            color: Colors.green,
                          ),
                          filled: true,
                          hintText: 'رقم الشحنة',
                          contentPadding: EdgeInsets.all(0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: trackShipment(widget.trackingNumber),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(widget.trackingNumber);
              if (snapshot.hasData && snapshot.data.data != null) {
                print('=================');
                print(snapshot.data.data);
                print('=================');
                String shipmentNumber = snapshot.data.data['shipment_id'];
                String shipmentStatus = snapshot.data.data['status'];
                Timestamp shipmentDate = snapshot.data.data['registrationDate'];
                String shipmentDateStr =
                    (shipmentDate.toDate().year).toString() +
                        '/' +
                        (shipmentDate.toDate().month).toString() +
                        '/' +
                        (shipmentDate.toDate().day).toString();
                return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text('شحنة رقم'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    shipmentNumber,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                  Text(
                                    shipmentStatus,
                                    style: TextStyle(
                                        color: shipmentStatus == 'تم التوصيل'
                                            ? Colors.green
                                            : Colors.blue),
                                  ),
                                  Text(
                                    shipmentDateStr,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text('المندوب'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    shipmentNumber,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                  Text(
                                    shipmentStatus,
                                    style: TextStyle(
                                        color: shipmentStatus == 'تم التوصيل'
                                            ? Colors.green
                                            : Colors.blue),
                                  ),
                                  Text(
                                    shipmentDateStr,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    widget.trackingNumber == 0
                        ? ''
                        : 'لاتوجد أي شحنة بهذا الرقم!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
