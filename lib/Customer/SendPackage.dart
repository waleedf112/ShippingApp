import 'package:flutter/material.dart';

import '../main.dart';

class Shipment {
  int id;
  String status;
  String carrierName;
  String carrierPhone;
  DateTime registrationDate;
  int receiverId;
  List<Package> packages = new List();

  Shipment(i, r, p) {
    this.id = i;
    this.registrationDate = DateTime.now();
    this.receiverId = r;
    this.status = 'بانتظار المرسل';
    this.packages = p;
  }
}

class Package {
  int id;
  int height;
  int width;
  int depth;
  int weight;
  int cost;

  Package();
}

class SendPackage extends StatefulWidget {
  List<Package> packages = [new Package()];
  @override
  _SendPackageState createState() => _SendPackageState();
}

class _SendPackageState extends State<SendPackage> {
  _buildTextField({labelText, icon, function}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          keyboardType: TextInputType.numberWithOptions(
            decimal: false,
          ),
          onChanged: function,
          decoration: InputDecoration(
              labelText: labelText,
              isDense: true,
              enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.green),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.green),
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.green.withOpacity(0.7),
              )),
        ),
      ),
    );
  }

  _calculateCost(index) {
    Package tmp = widget.packages[index];
    int cost;
    try {
      cost = ((tmp.height + tmp.width + tmp.depth) * 0.1 * tmp.weight).floor();
      print(cost);
    } catch (e) {
      cost = 50;
    }
    if (cost < 50) cost = 50;
    widget.packages[index].cost = cost;
    return '$cost ريال';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.packages.add(new Package());
          });
        },
        child: Icon(Icons.add, size: 30),
      ),
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Shipment _shipment = new Shipment(
                  DateTime.now().millisecondsSinceEpoch,
                  DateTime.now().millisecondsSinceEpoch,
                  widget.packages);
            },
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListView.builder(
              itemCount: widget.packages.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _calculateCost(index),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red.withOpacity(0.8)),
                                    textAlign: TextAlign.end,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'بيانات الشحنة ${index + 1}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black.withOpacity(0.5)),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              )
                            ],
                          ),
                          _buildTextField(
                            icon: Icons.widgets,
                            labelText: 'الوزن',
                            function: (String s) => setState(() {
                              widget.packages[index].weight = int.parse(s);
                            }),
                          ),
                          _buildTextField(
                            icon: Icons.arrow_upward,
                            labelText: 'الارتفاع',
                            function: (String s) => setState(() {
                              widget.packages[index].depth = int.parse(s);
                            }),
                          ),
                          _buildTextField(
                            icon: Icons.compare_arrows,
                            labelText: 'العرض',
                            function: (String s) => setState(() {
                              widget.packages[index].width = int.parse(s);
                            }),
                          ),
                          _buildTextField(
                            icon: Icons.arrow_back,
                            labelText: 'الطول',
                            function: (String s) => setState(() {
                              widget.packages[index].height = int.parse(s);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

/*
SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'بيانات المرسل',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          )
                        ],
                      ),
                      _buildTextField(
                          icon: Icons.location_city, labelText: 'المدينة'),
                      _buildTextField(
                          icon: Icons.store_mall_directory,
                          labelText: 'العنوان'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'بيانات المستلم',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          )
                        ],
                      ),
                      _buildTextField(
                          icon: Icons.person, labelText: 'اسم المستلم'),
                      _buildTextField(
                          icon: Icons.phone_iphone, labelText: 'رقم الجوال'),
                      _buildTextField(
                          icon: Icons.location_city, labelText: 'المدينة'),
                      _buildTextField(
                          icon: Icons.store_mall_directory,
                          labelText: 'العنوان'),
                    ],
                  ),
                ),
              ),
            )
*/
