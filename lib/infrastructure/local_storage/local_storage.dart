import 'package:cupid/application/local_key.dart';
import 'package:cupid/domain/model/auth_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MyHydratedStorage implements Storage {
  @override
  dynamic read(String key) {
    return HydratedBloc.storage.read(key);
  }

  @override
  Future<void> write(String key, value) async {
    return HydratedBloc.storage.write(key, value);
  }

  @override
  Future<void> delete(String key) async {
    return HydratedBloc.storage.delete(key);
  }

  @override
  Future<void> clear() async {
    return HydratedBloc.storage.clear();
  }

  getUser() {
    AuthModel? user;
    var data = MyHydratedStorage().read(
      LocalKey.login,
    );
    if (data != null) {
      user = authModelFromJson(data);
    } else {
      user = null;
    }
    return user;
  }
}
