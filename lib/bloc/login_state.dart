import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable{

  @override
  List<Object> get props {
    return [];
  }
}

class LoginFailed extends LoginState {}

class LoginSuccess extends LoginState {}

class InitialLoginState extends LoginState {}
