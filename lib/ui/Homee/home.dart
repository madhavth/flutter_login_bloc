import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/bloc/authentication_bloc.dart';
import 'package:flutter_login_demo/bloc/authentication_event.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[Colors.blue,Colors.black54],
        )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            typeWriter(),
            FutureBuilder(
              builder: (context, snapshot){
                if(snapshot.data!=null)
                return ColorizeAnimatedTextKit(
                  isRepeatingAnimation: true,
                  speed: Duration(
                    seconds: 2
                  ),
                  text: [snapshot.data],
                  textStyle: TextStyle(
                      fontSize: 50,
                      color: Colors.amber
                  ), colors: <Color>[Colors.amber,Colors.blue],
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart,
                );
                else
                  return Text('Loading...');
              },
              future: getUserName(),
            ),
            SizedBox(height: 20,),
            MaterialButton(
              child: Text('Logout',style: TextStyle(color: Colors.white),),
              onPressed: ()
              {
                logOutAndClear();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid
                )
              ),
              highlightColor: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
  
  Widget typeWriter()
  {
    return TyperAnimatedTextKit(
      speed: Duration(milliseconds: 50),
      isRepeatingAnimation: false,
      text: ['Welcome'],
      textStyle: TextStyle(
        color: Colors.amber,
        fontSize: 70,
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
