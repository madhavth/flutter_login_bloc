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

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if(state is LoginSuccess)
          {
            showFlushBar('Logged In',Duration(seconds: 2));
            context.bloc<AuthenticationBloc>().add(AppLoggedIn());
          }

        else if (state is LoginFailed)
          {
            showFlushBar('Login Failed, set password empty, but not username ty',Duration(seconds: 3));
          }

        else
          {

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
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
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


