import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseRequest {
  Future<String> apiRequest(String url, Map jsonMap, {token}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer $token',
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonMap,
    );
    return response.body;
  }
}
