part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class FirebaseLoading extends DashboardState {
  const FirebaseLoading();
  @override
  List<Object?> get props => [];
}

class AddContactLoaded extends DashboardState {
  const AddContactLoaded({this.data});
  final String? data;
  @override
  List<Object?> get props => [data];
}

class FirebaseError extends DashboardState {
  const FirebaseError({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}

class ProfileLoaded extends DashboardState {
  const ProfileLoaded({this.data});
  final AuthModel? data;
  @override
  List<Object?> get props => [data];
}

class ProfileError extends DashboardState {
  const ProfileError({this.message});
  final String? message;
  @override
  List<Object?> get props => [message];
}

class ProfileUpdateLoaded extends DashboardState {
  const ProfileUpdateLoaded({
    this.data,
  });
  final AuthModel? data;

  @override
  List<Object?> get props => [data];
}
