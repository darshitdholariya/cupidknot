part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class FetchRegister extends AuthEvent {
  const FetchRegister(
      {this.dob,
      this.gender,
      this.email,
      this.name,
      this.confirmPass,
      this.pass,
      this.phone});
  final String? email;
  final String? name;
  final String? pass;
  final String? confirmPass;
  final String? dob;
  final String? phone;
  final String? gender;
  @override
  List<Object?> get props => [phone, pass, confirmPass, name, email, gender];
}

class FetchLogin extends AuthEvent {
  const FetchLogin({this.email, this.pass});
  final String? email;
  final String? pass;

  @override
  List<Object?> get props => [email, pass];
}
