import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent{

  final String username;
  final String password;

  LoginButtonPressed(this.username, this.password);

  @override
  List<Object> get props => [];
}