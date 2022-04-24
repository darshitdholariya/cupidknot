part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  const AuthLoaded({this.dataModel});
  final AuthModel? dataModel;
}

class AuthError extends AuthState {
  const AuthError({this.message});
  final String? message;
  @override
  List<Object> get props => [message!];
}
