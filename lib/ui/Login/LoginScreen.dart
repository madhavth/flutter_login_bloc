import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/bloc/bloc.dart';
import 'package:flutter_login_demo/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) {
          return LoginBloc();
        },
        child: Stack(
          children: <Widget>[
//            myImage(context),
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.blue, Colors.black
                  ]
                  )
                ),
                child: LoginForm()),
          ],
        ));
  }

  Widget myImage(context)
  {
    return Image(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height, 
      image: AssetImage('assets/login.jpg'),
      fit: BoxFit.cover,
      color: Colors.black,
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final _showLoading = Flushbar(message: 'Checking..');

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if(state is LoginSuccess)
          {
            _showLoading.dismiss();
            showFlushBar('Logged In',Duration(seconds: 2));
            context.bloc<AuthenticationBloc>().add(AppLoggedIn());
          }

        else if (state is LoginFailed)
          {
            _showLoading.dismiss();
            showFlushBar('Login Failed',Duration(seconds: 2));
          }

        else if (state is LoginChecking)
          {
            _showLoading.show(context);
          }

        else {
           _showLoading.dismiss();
        }
    },
      child: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              formField('Enter Username here', textController1,false,'Username'),
              formField('Enter Password here', textController2,true,'Password'),
              SizedBox(height: 20,),
              MaterialButton(onPressed: () {
                checkLogin();
              },
                focusColor: Colors.amberAccent.withOpacity(0.2),
                highlightColor: Colors.amber,
                child: Text('Login', style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formField(hint,controller,obscure,labelText) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      child: TextFormField(
        style: TextStyle(
          decorationColor:Colors.black12,
          color: Colors.white
        ),

        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Colors.amber
          ),
          labelText: labelText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3)
          ),
          hintText: hint,
        ),
      ),
    );
  }

  void checkLogin() {
    context.bloc<LoginBloc>().add(LoginButtonPressed(textController1.text,textController2.text));
  }

  void showFlushBar(message,duration)
  {
    Flushbar(message: message,duration: duration).show(context);
  }
}


