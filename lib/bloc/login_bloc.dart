import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_login_demo/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {

    if(event is LoginButtonPressed)
      {
        yield InitialLoginState();

        //tori check logic
        try{
            if(event.username !="" && event.password == "")
              {
                yield LoginChecking();
                await Future.delayed(Duration(seconds: 1));
                final prefs = await SharedPreferences.getInstance();
                prefs.setInt(Const.LOGINCHECK, 1);
                prefs.setString(Const.USERNAME,event.username);
                yield LoginSuccess();
              }
            else
              yield LoginFailed();
        }
        catch(e)
        {
          yield LoginFailed();
        }
      }
  }
}
