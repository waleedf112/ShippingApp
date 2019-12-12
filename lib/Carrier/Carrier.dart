import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/CarrierOrder.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/CustomerOrder.dart';
import 'package:database2_project_shipping_app/FirebaseDatabase/SignupAndSignin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../loading.dart';
import '../main.dart';

class CarrierScreen extends StatefulWidget {
  @override
  _CarrierScreenState createState() => _CarrierScreenState();
}

class _CarrierScreenState extends State<CarrierScreen> {
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
                              String shipmentSender = snapshot
                                  .data.documents[index]['sender_userName'];
                              Timestamp shipmentDate = snapshot
                                  .data.documents[index]['registrationDate'];
                              String shipmentDateStr =
                                  (shipmentDate.toDate().year).toString() +
                                      '/' +
                                      (shipmentDate.toDate().month).toString() +
                                      '/' +
                                      (shipmentDate.toDate().day).toString();
                              return FutureBuilder(
                                  future: getSender(shipmentSender),
                                  builder: (context, snapshot3) {
                                    if (snapshot3.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                            shipmentDateStr,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: <Widget>[
                                                      Text('العميل'),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            snapshot3
                                                                .data['name'],
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
                                                            snapshot3.data[
                                                                'phoneNumber'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),
                                                  shipmentStatus ==
                                                          'في طريقها للمستلم'
                                                      ? CustomButton(
                                                          fontSize: 16,
                                                          labelText:
                                                              'تسليم الشحنة للمستلم',
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          function: () {
                                                            updateStatus(
                                                                shipmentNumber,
                                                                'تم التوصيل!');
                                                            delivered(
                                                                shipmentNumber);
                                                          },
                                                        )
                                                      : CustomButton(
                                                          fontSize: 16,
                                                          labelText: 'استلام',
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          function: () =>
                                                              updateStatus(
                                                                  shipmentNumber,
                                                                  'في طريقها للمستلم'),
                                                        )
                                                ],
                                              ),
                                            )),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 200),
                                        child: SpinKitHourGlass(
                                          color: Colors.green.withOpacity(0.3),
                                          size: 50.0,
                                        ),
                                      );
                                    }
                                  });
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
                            itemCount: snapshot.data.documents.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              String shipmentNumber =
                                  snapshot.data.documents[index]['shipment_id'];
                              String shipmentStatus =
                                  snapshot.data.documents[index]['status'];
                              int shipmentReceiver =
                                  snapshot.data.documents[index]['receiverId'];
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
                                    return StreamBuilder(
                                        stream: getReceiver(shipmentReceiver),
                                        builder: (context, snapshot5) {
                                          if (snapshot5.hasData &&
                                              snapshot5.data.documents.length >
                                                  0) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  elevation: 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          children: <Widget>[
                                                            Text('شحنة رقم'),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
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
                                                                          ? Colors
                                                                              .green
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          children: <Widget>[
                                                            Text('من'),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          children: <Widget>[
                                                            Text('الى'),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  snapshot5.data
                                                                          .documents[0]
                                                                      [
                                                                      'receiverCity'],
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
                                                                  snapshot5.data
                                                                          .documents[0]
                                                                      [
                                                                      'receiverAddress'],
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
                                                                      color: Colors
                                                                          .green),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        CustomButton(
                                                          labelText: 'قبول',
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          fontSize: 16,
                                                          function: () async {
                                                            await assignToShipment(
                                                                shipmentNumber);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        });
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
