import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_demo/bloc/LoginEvent.dart';
import 'LoginEvent.dart';

class LoginBloc extends Bloc<LoginEvent,LoginEvent> {
  @override
  LoginEvent get initialState => LoginEvent.INITIAL;

  @override
  Stream<LoginEvent> mapEventToState(LoginEvent event) async* {
    switch(event)
    {
      case LoginEvent.LOGGEDIN:
        yield LoginEvent.LOGGEDIN;
        break;
      case LoginEvent.INITIAL:
        yield LoginEvent.INITIAL;
        break;
      case LoginEvent.LOGGEDOUT:
        yield LoginEvent.LOGGEDOUT;
        break;
    }
  }

}