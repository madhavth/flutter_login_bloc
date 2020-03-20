import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/ui/LoggedIn/my_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 50,
                    sigmaY: 50
                ),
                //     child: Image(
                //       repeat: ImageRepeat.repeatY,
                //       fit: BoxFit.cover,
                //       image: AssetImage('assets/login.jpg'),
                // ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'enter username here',
                          labelText: 'Username'
                      ),
                      controller: _textController1,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'enter password here'
                      ),
                      controller: _textController2,
                    ),
                    SizedBox(height: 10,),

                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide()
                      ),
                      highlightColor: Colors.amber.withOpacity(0.7),
                      child: Text('Login'),
                      onPressed: () {
                        String username = _textController1.text;
                        String password = _textController2.text;
                        print('username and password are $username & $password');

                        //tori check logic
                        if (true) //(username == 'admin' && password == 'admin')
                            {
                          //shared preference check as loggedin
                          loginLog();

                          _textController1.clear();
                          _textController2.clear();
                          //login accepted
                          Flushbar(
                            duration: Duration(seconds: 2),
                            message: 'Logged in successfully!!',
                          ).show(context);

                          //navigate to another page
                          navigateToPage2(context);
                        }

                        else {
                          _textController2.clear();
                          Flushbar(
                            duration: Duration(seconds: 2),
                            message: 'Incorrect username / password!!',
                          ).show(context);
                        }
                      },

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

  void navigateToPage2(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyProfilePage()
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _textController1.dispose();
    _textController2.dispose();
  }


  void loginLog() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.getInt('loginCheck'?? 0);
    await sharedPref.setInt('loginCheck', 1);
  }
}