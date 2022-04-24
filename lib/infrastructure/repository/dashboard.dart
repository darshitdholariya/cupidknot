import 'dart:convert';

import 'package:cupid/application/api.dart';
import 'package:cupid/domain/model/auth_model.dart';
import 'package:cupid/domain/service/http_client.dart';
import 'package:cupid/infrastructure/local_storage/local_storage.dart';

class DashboardRepo {
  Future<AuthModel> getProfile() async {
    final data = await MyHydratedStorage().getUser();
    return data;
  }

  updateProfile(
      {String? name, String? mob, String? gender, String? dob}) async {
    AuthModel? local = MyHydratedStorage().getUser();
    final data = await BaseRequest().apiRequest(Api.base + Api.updateProfile,
        {"full_name": name, "mobile_no": mob, "gender": gender, "dob": dob},
        token: local!.data.token);
    if (jsonDecode(data)['success'] == false) {
      return null;
    } else {
      return data;
    }
  }
}
