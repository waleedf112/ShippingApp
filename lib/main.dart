import 'package:flutter/material.dart';

import 'Carrier/DeliveryScreen.dart';
import 'Sender/Send_Shipment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
          child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: ()  => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DeliveryScreen())),
                child: Text('توصيل'),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SenderScreen())),
                child: Text('ارسال شحنه'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('تتبع'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
