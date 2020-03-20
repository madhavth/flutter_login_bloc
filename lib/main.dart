import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/ui/LoggedIn/my_profile.dart';
import 'package:flutter_login_demo/ui/Login/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/LoginBloc.dart';
import 'bloc/LoginEvent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: SafeArea(child: Scaffold(body: MyLoginPage())),
    );
  }
}


class MyLoginPage extends StatefulWidget {

  @override
  _MyLoginPageState createState(){
  return _MyLoginPageState();
  }
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {

    return SplashScreenPage();
//    if(widget.loggedInCheck == 0)
//      {
//        return MyHomePage();
//      }
//    else
//      {
//        return MyProfilePage();
//      }
  }
}


class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  final loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => loginBloc,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocListener<LoginBloc, LoginEvent>(
              listener: (BuildContext context, state) {
                if(state == LoginEvent.LOGGEDIN)
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => MyProfilePage()
                    ));
                  }

                else if(state == LoginEvent.LOGGEDOUT)
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => LoginPage()
                    ));
                  }
              },
              child: Container(
                child: CircularProgressIndicator(
                  strokeWidth: 12,
                  backgroundColor: Colors.black,
                  semanticsLabel: 'Loading',
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Loading',style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }



  void checkIfLoggedIn() async{
    var prefs = await SharedPreferences.getInstance();
    var loggedIn = prefs.getInt('loginCheck'??0);

    print('loggedIn main is $loggedIn');
    if(loggedIn == 1)
      {
         loginBloc.add(LoginEvent.LOGGEDIN);
      }

    else
      {
        loginBloc.add(LoginEvent.LOGGEDOUT);
      }

  }
}



