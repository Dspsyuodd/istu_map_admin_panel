import 'dart:convert';

import 'package:istu_map_admin_panel/admin_panel/constants/api_constants.dart';
import 'package:istu_map_admin_panel/admin_panel/core/api_client.dart';
import 'package:istu_map_admin_panel/admin_panel/data/models/waypoint_model.dart';

abstract interface class WaypointDataSource {
  Future<String> create(WaypointModel object);
  Future<void> delete(String guid);
  Future<WaypointModel> get(String guid);
}

class WaypointDataSourceImpl implements WaypointDataSource {
  final ApiClient client;

  WaypointDataSourceImpl(this.client);

  @override
  Future<String> create(WaypointModel object) async {
    return (await client.post(ApiConstants.baseUrl + ApiConstants.waypoints,
            body: object.toJson()))
        .body;
  }

  @override
  Future<void> delete(String guid) async {
    await client.delete(ApiConstants.baseUrl + ApiConstants.waypoints + guid);
  }

  @override
  Future<WaypointModel> get(String guid) async {
    var responce = await client.get(ApiConstants.baseUrl + ApiConstants.waypoints + guid);
    return WaypointModel.fromJson(jsonDecode(responce.body));
  }
}
