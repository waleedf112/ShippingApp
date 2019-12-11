import 'package:flutter/material.dart';
import 'FirebaseDatabase/SignupAndSignin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

  Widget _buildButton({labelText, function}) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.green,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              labelText,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      onPressed: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
          child: Scaffold(
        backgroundColor: Colors.green,
        body: ListView(
          reverse: true,
          children: <Widget>[
            Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                          _buildButton(
                            labelText: 'تسجيل',
                            function: () {
                              if (usernameController.text.trim().isNotEmpty &&
                                  passwordController.text.trim().isNotEmpty)
                                registerUser(context, {
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
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Scaffold()),
                                    );
                                  }
                                });
                            },
                          ),
                          SizedBox(height: 20),
                          _buildButton(
                            labelText: 'الدخول',
                            function: () {
                              if (usernameController.text.trim().isNotEmpty &&
                                  passwordController.text.trim().isNotEmpty)
                                loginUser(context, {
                                  'username': usernameController.text,
                                  'password': passwordController.text,
                                }).then((successful) {
                                  if (successful) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Scaffold()),
                                    );
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
            )
          ],
        ),
      ),
    );
  }
}

/* 
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
 */
