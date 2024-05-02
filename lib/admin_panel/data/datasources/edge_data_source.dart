import 'dart:convert';

import 'package:istu_map_admin_panel/admin_panel/constants/api_constants.dart';
import 'package:istu_map_admin_panel/admin_panel/core/api_client.dart';
import 'package:istu_map_admin_panel/admin_panel/data/models/edge_model.dart';

abstract interface class EdgeDataSource {
  Future<String> create(EdgeModel object);
  Future<void> delete(String guid);
  Future<EdgeModel> get(String guid);
}

class EdgeDataSourceImpl implements EdgeDataSource {
  final ApiClient client;

  EdgeDataSourceImpl(this.client);
  @override
  Future<String> create(EdgeModel object) async {
    final responce = await client
        .post(ApiConstants.baseUrl + ApiConstants.edges, body: object.toJson());
    return responce.body;
  }

  @override
  Future<void> delete(String guid) async {
    await client.delete(ApiConstants.baseUrl + ApiConstants.edges + guid);
  }

  @override
  Future<EdgeModel> get(String guid) async {
    var responce =
        await client.get(ApiConstants.baseUrl + ApiConstants.edges + guid);
    return EdgeModel.fromJson(jsonDecode(responce.body));
  }
}
