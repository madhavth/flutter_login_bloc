import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable{

  @override
  List<Object> get props {
    return [];
  }
}

class InitialAuthenticationState extends AuthenticationState {

  @override
  String toString() {
    return 'InitialAuthenticationState';
  }
}

class LoggedInState extends AuthenticationState{

  @override
  String toString() {
    return 'LoggedInState';
  }
}
class LoggedOutState extends AuthenticationState{

  @override
  String toString() {
    return 'LoggedOutState';
  }
}