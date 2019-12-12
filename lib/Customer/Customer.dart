import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/CustomerOrder.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/SignupAndSignin.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'SendPackage.dart';

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'مرحبا بك يا ${currentUser.name}',
            textDirection: TextDirection.rtl,
          ),
          centerTitle: true,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          //shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CustomButton(
                    labelText: 'ارسال شحنة',
                    padding: EdgeInsets.symmetric(vertical: 5),
                    fontSize: 14,
                    expanded: true,
                    icon: Icons.local_shipping,
                    function: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SendPackage()),
                    ),
                  ),
                  SizedBox(width: 10),
                  CustomButton(
                    labelText: 'تتبع شحنة',
                    padding: EdgeInsets.symmetric(vertical: 5),
                    fontSize: 14,
                    expanded: true,
                    icon: Icons.call_merge,
                    isRTL: true,
                  )
                ],
              ),
            ),
            StreamBuilder(
                stream: getAllActiveShipments(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      String shipmentNumber =
                          snapshot.data.documents[index]['shipment_id'];
                      String shipmentStatus =
                          snapshot.data.documents[index]['status'];
                      Timestamp shipmentDate =
                          snapshot.data.documents[index]['registrationDate'];
                      String shipmentDateStr =
                          (shipmentDate.toDate().year).toString() +
                              '/' +
                              (shipmentDate.toDate().month).toString() +
                              '/' +
                              (shipmentDate.toDate().day).toString();
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: <Widget>[
                                  Text('شحنة رقم'),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        shipmentNumber,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      Text(
                                        shipmentStatus,
                                        style: TextStyle(
                                            color:
                                                shipmentStatus == 'تم التوصيل'
                                                    ? Colors.green
                                                    : Colors.blue),
                                      ),
                                      Text(
                                        shipmentDateStr,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.3)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
