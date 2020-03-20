import 'package:flutter/material.dart';
import 'package:flutter_login_demo/ui/Login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text('I dont know what should be here'),
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                logOut();
              },

            )
          ],
        ),
      ),
    );
  }

  void logOut() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('loginCheck', 0);
    int a = prefs.getInt('loginCheck');
    print('myprofile logincheck is $a');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)
    =>MyApp()
    ));
  }
}