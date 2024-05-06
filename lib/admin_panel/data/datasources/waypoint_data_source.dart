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

var a = {
  "Type": "https://tools.ietf.org/html/rfc9110#section-15.5.1",
  "Title": "One or more validation errors occurred.",
  "Status": 400,
  "Errors": {
    "request": ["The request field is required."],
    "Type": [
      "The JSON value could not be converted to Istu.Navigation.Domain.Models.BuildingRoutes.BuildingObjectType. Path: Type | LineNumber: 0 | BytePositionInLine: 95."
    ]
  },
  "traceId": "00-bfd526ea008c44c13b0540db5bf2f17f-0554670b083050f8-00",
};
