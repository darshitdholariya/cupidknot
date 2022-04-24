part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class AddContact extends DashboardEvent {
  const AddContact({this.id, this.email, this.name, this.phone});
  final String? id;
  final String? email;
  final String? phone;
  final String? name;
  @override
  // TODO: implement props
  List<Object?> get props => [id, phone, name, email];
}

class GetProfile extends DashboardEvent {
  const GetProfile();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends DashboardEvent {
  const UpdateProfile({this.dob, this.gender, this.name, this.phone});
  final String? name;
  final String? phone;
  final String? gender;
  final String? dob;
  @override
  List<Object?> get props => [gender, dob, phone, name];
}
