import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SendPackage extends StatefulWidget {
  GlobalKey _formKey = new GlobalKey();

  @override
  _SendPackageState createState() => _SendPackageState();
}

class _SendPackageState extends State<SendPackage> {
  _buildTextField({controller, labelText, icon, validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: validator,
          controller: controller,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Form(
        key: widget._formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
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
                                'بيانات الشحنة',
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
                          icon: Icons.person, labelText: 'الوزن'),
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
                          icon: Icons.person, labelText: 'اسم المرسل'),
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
          ],
        ),
      ),
    );
  }
}
