import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const.dart';
import './bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    print('AuthenticationBloc event is $event');
    if(event is AppStarted)
      {
        yield InitialAuthenticationState();
      }

    else if(event is AppLoggedIn)
      {
        final prefs=  await SharedPreferences.getInstance();
        prefs.setInt(Const.LOGINCHECK, 1);
        yield LoggedInState();
      }

    else if(event is  AppLoggedOut)
      {
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt(Const.LOGINCHECK, 0);
        yield LoggedOutState();
      }
  }
}
