import 'package:bloc/bloc.dart';
import 'package:cupid/application/local_key.dart';
import 'package:cupid/domain/model/auth_model.dart';
import 'package:cupid/infrastructure/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';

import '../../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is FetchLogin) {
        AuthModel? data;
        try {
          emit(AuthLoading());
          data = await AuthRepository.getLogin(
              email: event.email, password: event.pass);
          MyHydratedStorage().write(LocalKey.login, authModelToJson(data));
          emit(AuthLoaded(dataModel: data));
        } catch (e) {
          emit(AuthError(message: data!.message));
        }
      } else if (event is FetchRegister) {
        AuthModel? data;
        try {
          emit(AuthLoading());
          data = await AuthRepository.getRegister(
              email: event.email,
              name: event.name,
              password: event.pass,
              c_password: event.confirmPass,
              dob: event.dob,
              gender: event.gender,
              mobile_no: event.phone);
          MyHydratedStorage().write(LocalKey.login, authModelToJson(data));

          emit(AuthLoaded(dataModel: data));
        } catch (e) {
          emit(AuthError(message: data!.message));
        }
      }
    });
  }
}
