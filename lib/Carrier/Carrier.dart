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
            'مرحبا بك يا ${currentUser.username}',
            textDirection: TextDirection.rtl,
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}