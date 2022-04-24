import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cupid/application/local_key.dart';
import 'package:cupid/domain/model/auth_model.dart';
import 'package:cupid/infrastructure/firebase/firebase.dart';
import 'package:cupid/infrastructure/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';

import '../../repository/dashboard.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      if (event is AddContact) {
        emit(const FirebaseLoading());
        final data = await FirebaseRepo().addUser(
            id: event.id,
            contact: event.phone,
            email: event.email,
            name: event.name);
        if (data.contains('Successfully')) {
          emit(AddContactLoaded(data: data));
        } else {
          emit(const FirebaseError(message: 'Firebase Error'));
        }
      } else if (event is GetProfile) {
        emit(const FirebaseLoading());
        try {
          final data = await DashboardRepo().getProfile();
          emit(ProfileLoaded(data: data));
        } catch (e) {
          emit(const ProfileError(message: 'Something Went Wrong'));
        }
      } else if (event is UpdateProfile) {
        emit(const FirebaseLoading());
        try {
          final data = await DashboardRepo().updateProfile(
              name: event.name,
              mob: event.phone,
              dob: event.dob,
              gender: event.gender);
          AuthModel? local = MyHydratedStorage().getUser();
          var maps = {
            "success": local!.success,
            "data": {
              "user_details": jsonDecode(data)['data']['user_details'],
              "token": local.data.token
            },
            "message": local.message
          };
          MyHydratedStorage().write(LocalKey.login, json.encode(maps));
          emit(ProfileUpdateLoaded(data: authModelFromJson(data)));
        } catch (e) {
          emit(const ProfileError(message: 'Something Went Wrong'));
        }
      }
    });
  }
}
