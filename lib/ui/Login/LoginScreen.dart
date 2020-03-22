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
        child: LoginForm());
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
            showFlushBar('Login Failed, set password empty, but not username ty',Duration(seconds: 3));
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
              formField('Username', textController1,false),
              formField('Password', textController2,true),
              SizedBox(height: 20,),
              MaterialButton(onPressed: () {
                checkLogin();
              },
                highlightColor: Colors.amber,
                child: Text('Login'),
                shape: RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: BorderRadius.circular(12)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formField(hint,controller,obscure) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Colors.black38
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


