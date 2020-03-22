import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/bloc/authentication_bloc.dart';
import 'package:flutter_login_demo/bloc/authentication_event.dart';
import 'package:flutter_login_demo/bloc/authentication_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<String> getUserName() async
{
  final prefs= await SharedPreferences.getInstance();
  return prefs.getString(Const.USERNAME);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            builder: (context, snapshot){
              return Text('Welcome, ${snapshot.data}',style: TextStyle(fontSize: 32, color: Colors.amberAccent),);
            },
            initialData: Text('Loading..'),
            future: getUserName(),
          ),
          MaterialButton(
            child: Text('Logout'),
            onPressed: ()
            {
              logOutAndClear();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide()
            ),
            highlightColor: Colors.blue,
          )
        ],
      ),
    );
  }

  void logOutAndClear() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(Const.LOGINCHECK,0);
    prefs.setString(Const.USERNAME, "");
    context.bloc<AuthenticationBloc>().add(AppStarted());
    Flushbar(message: 'Logged Out',duration: Duration(seconds: 2),).show(context);
  }
}
