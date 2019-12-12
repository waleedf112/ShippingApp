import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/CarrierOrder.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/CustomerOrder.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/SignupAndSignin.dart';
import 'package:flutter/material.dart';

class CarrierScreen extends StatelessWidget {
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
        body: StreamBuilder(
            stream: isBusy(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['isBusy'] != null &&
                    snapshot.data['isBusy']) {
                  return StreamBuilder(
                      stream: getActiveShipment(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              String shipmentNumber =
                                  snapshot.data.documents[index]['shipment_id'];
                              String shipmentStatus =
                                  snapshot.data.documents[index]['status'];
                              Timestamp shipmentDate = snapshot
                                  .data.documents[index]['registrationDate'];
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    color: Colors.black
                                                        .withOpacity(0.6)),
                                              ),
                                              Text(
                                                shipmentStatus,
                                                style: TextStyle(
                                                    color: shipmentStatus ==
                                                            'تم التوصيل'
                                                        ? Colors.green
                                                        : Colors.blue),
                                              ),
                                              Text(
                                                shipmentDateStr,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.3)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        }
                        return Container();
                      });
                } else {
                  return StreamBuilder(
                      stream: getAllAvailibleShipments(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data.documents.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              String shipmentNumber =
                                  snapshot.data.documents[index]['shipment_id'];
                              String shipmentStatus =
                                  snapshot.data.documents[index]['status'];
                              Timestamp shipmentDate = snapshot
                                  .data.documents[index]['registrationDate'];
                              String shipmentDateStr =
                                  (shipmentDate.toDate().year).toString() +
                                      '/' +
                                      (shipmentDate.toDate().month).toString() +
                                      '/' +
                                      (shipmentDate.toDate().day).toString();
                              String senderCity =
                                  snapshot.data.documents[index]['senderCity'];
                              String senderAddress = snapshot
                                  .data.documents[index]['senderAddress'];

                              return FutureBuilder(
                                  future: getShipmentPrice(snapshot
                                      .data.documents[index]['shipment_id']),
                                  builder: (context, snapshot2) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: <Widget>[
                                                    Text('شحنة رقم'),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          shipmentNumber,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                        Text(
                                                          shipmentStatus ==
                                                                  'بانتظار قبول اي مندوب'
                                                              ? 'متوفرة'
                                                              : '',
                                                          style: TextStyle(
                                                              color: shipmentStatus ==
                                                                      'بانتظار قبول اي مندوب'
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .blue),
                                                        ),
                                                        Text(
                                                          shipmentDateStr,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3)),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: <Widget>[
                                                    Text('من'),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          senderCity,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                        Text(
                                                          senderAddress,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                        ),
                                                        Text(
                                                          snapshot2.data
                                                                  .toString() +
                                                              ' ريال',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                          textDirection:
                                                              TextDirection.rtl,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                                  });
                            },
                          );
                        }
                        return Container();
                      });
                }
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
