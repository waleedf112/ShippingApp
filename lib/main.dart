import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Carrier/Carrier.dart';
import 'Customer/Customer.dart';
import 'FirebaseDatabase/SignupAndSignin.dart';
import 'loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF2F3F8),
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Widget _buildTextField({icon, labelText, controller}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            prefixIcon: Icon(
              icon,
              color: Colors.green.withOpacity(0.7),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      usernameController.text = 's';
      passwordController.text = 's';
    }
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.local_shipping,
              size: 150,
              color: Colors.white.withOpacity(0.9),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _buildTextField(
                            icon: Icons.person,
                            controller: usernameController,
                            labelText: 'اسم المستخدم',
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            icon: Icons.lock,
                            controller: passwordController,
                            labelText: 'كلمة السر',
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            labelText: 'تسجيل',
                            function: () async {
                              if (usernameController.text.trim().isNotEmpty &&
                                  passwordController.text.trim().isNotEmpty)
                                await registerUser(context, {
                                  'username': usernameController.text,
                                  'password': passwordController.text,
                                }).then((userExist) {
                                  if (userExist) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title:
                                                new Text("اسم المستخدم موجود!"),
                                            content: new Text(
                                                "اسم المستخدم موجود مسبقاً!\n" +
                                                    "الرجاء اختيار اسم اخر او سجل دخولك اذا كنت مسجل من قبل."),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("حسناً"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    if (currentUser.type == null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                _ShowOptions()),
                                      );
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CarrierScreen()),
                                      );
                                    }
                                  }
                                });
                            },
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            labelText: 'الدخول',
                            function: () {
                              if (usernameController.text.trim().isNotEmpty &&
                                  passwordController.text.trim().isNotEmpty)
                                loginUser(context, {
                                  'username': usernameController.text,
                                  'password': passwordController.text,
                                }).then((successful) {
                                  if (successful) {
                                    if (currentUser.type == null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                _ShowOptions()),
                                      );
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerScreen()),
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title: new Text("حدث خطأ!"),
                                            content: new Text(
                                                "اسم المستخدم او كلمة المرور غير صحيحه!\n" +
                                                    "الرجاء التأكد من البيانات وحاول مرة اخرى, او التسجيل اذا لم تكن مسجلاً."),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("حسناً"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowOptions extends StatelessWidget {
  _buildTextField({controller, labelText, icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
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

  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('مرحباً بك'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'اختر نوع الحساب',
                        style: TextStyle(
                            fontSize: 30, color: Colors.black.withOpacity(0.7)),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        labelText: 'الاسم',
                        icon: Icons.person,
                        controller: name,
                      ),
                      _buildTextField(
                        labelText: 'رقم الجوال',
                        icon: Icons.person,
                        controller: phoneNumber,
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        labelText: 'مرسل او مستقبل',
                        function: () async => assignType(
                          context,
                          'Customer',
                          name.text.trim(),
                          phoneNumber.text.trim(),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        labelText: 'مندوب',
                        
                        function: () async => assignType(
                          context,
                          'Carrier',
                          name.text.trim(),
                          phoneNumber.text.trim(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String labelText;
  final Function function;
  final EdgeInsets padding;
  final double fontSize;
  final bool expanded;
  final bool isRTL;
  final IconData icon;
  CustomButton({
    this.labelText,
    this.function,
    this.padding,
    this.fontSize,
    this.expanded = false,
    this.isRTL = false,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    _build() {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Colors.green,
        elevation: 0,
        child: Row(
          textDirection: !isRTL ? TextDirection.ltr : TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon != null
                ? Icon(
                    icon,
                    color: Colors.white,
                  )
                : Container(),
            expanded
                ? Expanded(
                    child: Padding(
                      padding:
                          padding ?? const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        labelText ?? 'text',
                        style: TextStyle(
                            color: Colors.white, fontSize: fontSize ?? 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        padding ?? const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      labelText ?? 'text',
                      style: TextStyle(
                          color: Colors.white, fontSize: fontSize ?? 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
        onPressed: function ?? () {},
      );
    }

    return expanded
        ? Expanded(
            child: _build(),
          )
        : _build();
  }
}
