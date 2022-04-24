import 'dart:convert';

import 'package:cupid/application/api.dart';
import 'package:cupid/application/exceptions/authentication_exception.dart';
import 'package:cupid/domain/model/auth_model.dart';
import 'package:cupid/domain/service/http_client.dart';

class AuthRepository {
  static Future<AuthModel> getLogin({
    String? email,
    String? password,
  }) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    final data = await BaseRequest().apiRequest(Api.base + Api.login, body);

    if (jsonDecode(data)['success'] == false ||
        jsonDecode(data)['message'].toString().contains('Unauthorized')) {
      throw AuthenticationException(message: jsonDecode(data)['message']);
    } else {
      return authModelFromJson(data);
    }
  }

  static Future<AuthModel> getRegister(
      {String? email,
      String? mobile_no,
      String? name,
      String? password,
      String? c_password,
      String? gender,
      String? dob}) async {
    Map<String, dynamic> body = {
      "full_name": name,
      "email": email,
      "mobile_no": mobile_no,
      "password": password,
      "c_password": c_password,
      "gender": gender,
      "dob": dob
    };
    final data = await BaseRequest().apiRequest(Api.base + Api.register, body);
    if (jsonDecode(data)['success'] == false) {
      throw AuthenticationException(message: jsonDecode(data)['message']);
    } else {
      return authModelFromJson(data);
    }
  }
}
