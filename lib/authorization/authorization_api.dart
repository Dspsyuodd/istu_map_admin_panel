import 'dart:convert';

import 'package:istu_map_admin_panel/admin_panel/constants/api_constants.dart';
import 'package:istu_map_admin_panel/admin_panel/core/api_client.dart';
import 'dart:html';

import 'package:istu_map_admin_panel/core/errors/exceptions.dart';

class AuthorizationApi {
  final ApiClient client;

  AuthorizationApi(this.client);

  Future<bool> login(String email, String password) async {
    try {
      final response = await client.post(
        '${ApiConstants.baseUrl}users/login/',
        body: {
          'Email': email,
          'Password': password,
        },
      );
      print(response);
      document.cookie =
          "AccessToken=${jsonDecode(response.body)["AccessToken"]}";
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      if (e is ServerException) {
        print(e.code);
        print(e.message);
      }
      return false;
    }
  }
}
