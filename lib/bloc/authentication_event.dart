import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {

  @override
  List<Object> get props {
  return [];
  }
}

class AppStarted extends AuthenticationEvent{

  @override
  String toString() {
    return 'AppStarted';
  }
}

class AppLoggedIn extends AuthenticationEvent{

  @override
  String toString() {
    return 'AppLoggedIn';
  }
}

class AppLoggedOut extends AuthenticationEvent{

  @override
  String toString() {
    return 'AppLoggedOut';
  }
}