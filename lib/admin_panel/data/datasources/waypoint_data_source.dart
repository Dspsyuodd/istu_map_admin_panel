import 'dart:convert';

import '../../constants/api_constants.dart';
import '../../core/api_client.dart';
import '../models/waypoint_model.dart';

abstract interface class WaypointDataSource {
  Future<String> create(Map<String, dynamic> object);
  Future<void> delete(String guid);
  Future<WaypointModel> get(String guid);
}

class WaypointDataSourceImpl implements WaypointDataSource {
  final ApiClient client;

  WaypointDataSourceImpl(this.client);

  @override
  Future<String> create(Map<String, dynamic> object) async {
    var response = await client.post(
            ApiConstants.baseUrl +
                ApiConstants.buildings +
                ApiConstants.waypoints,
            body: object);
    return jsonDecode(response.body)['BuildingObjectId'];
  }

  @override
  Future<void> delete(String guid) async {
    await client.delete(ApiConstants.baseUrl + ApiConstants.buildings + ApiConstants.waypoints + guid);
  }

  @override
  Future<WaypointModel> get(String guid) async {
    var responce =
        await client.get(ApiConstants.baseUrl + ApiConstants.waypoints + guid);
    return WaypointModel.fromJson(jsonDecode(responce.body));
  }
}