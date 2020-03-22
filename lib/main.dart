import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/bloc/authentication_event.dart';
import 'package:flutter_login_demo/bloc/authentication_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/authentication_bloc.dart';
import 'const.dart';
import 'ui/Homee/home.dart';
import 'ui/Login/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) {
            return AuthenticationBloc();
          },
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: context.bloc<AuthenticationBloc>(),
        builder: (BuildContext context, state) {

          print('blocConsumer state is $state');

        if(state is LoggedInState)
          return HomeScreen();

        else if(state is LoggedOutState)
          return LoginScreen();

        else
          return SplashScreen();
      },
        listener: (BuildContext context, state) {

        },
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    print('splash screen initState called');
    checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 12,
            backgroundColor: Colors.amber,
          ),
          SizedBox(height: 30,),
          Text('Loading',style: TextStyle(fontSize: 30,color: Colors.amberAccent),),
        ],
      ),
    );
  }

  void checkIfLoggedIn() async{
    await Future.delayed(Duration(seconds: 2));
    final prefs= await SharedPreferences.getInstance();
    int check = prefs.getInt(Const.LOGINCHECK??0);

    if(check == 0)
    {
      context.bloc<AuthenticationBloc>().add(AppLoggedOut());
    }

    else
    {
      context.bloc<AuthenticationBloc>().add(AppLoggedIn());
    }
  }
}




