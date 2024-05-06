import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/errors/exceptions.dart';

abstract interface class ApiClient {
  Future<http.Response> get(String url);
  Future<http.Response> post(String url, {Object? body});
  Future<http.Response> delete(String url);
  Future<http.Response> patch(String url, {Object? body});
}

class ApiClientImpl implements ApiClient {
  final http.Client client;

  ApiClientImpl(this.client);

  @override
  Future<http.Response> get(String url) async {
    var response = await client.get(
      Uri.parse(url),
    );
    _handleErrors(response);
    return response;
  }

  @override
  Future<http.Response> post(String url, {Object? body}) async {
    var response = await client.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    _handleErrors(response);
    return response;
  }

  @override
  Future<http.Response> delete(String url) async {
    var response = await client.delete(Uri.parse(url));
    _handleErrors(response);
    return response;
  }

  @override
  Future<http.Response> patch(String url, {Object? body}) async {
    var response = await client.patch(Uri.parse(url), body: body);
    _handleErrors(response);
    return response;
  }

  void _handleErrors(http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 202) {
      throwException(response);
    }
  }

  Never throwException(http.Response response) {
    throw ServerException(response.body, response.statusCode);
  }
}
