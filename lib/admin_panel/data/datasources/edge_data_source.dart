import 'dart:convert';

import 'package:istu_map_admin_panel/admin_panel/constants/api_constants.dart';
import 'package:istu_map_admin_panel/admin_panel/core/api_client.dart';
import 'package:istu_map_admin_panel/admin_panel/data/models/edge_model.dart';

abstract interface class EdgeDataSource {
  Future<String> create(Map<String, dynamic> object);
  Future<void> delete(String guid);
  Future<EdgeModel> get(String guid);
  Future<List<EdgeModel>> getMany({
    String? buildingid,
    String? fromBuildingObjectId,
    String? toBuildingObjectId,
    int? floorNumber,
    String? skip,
    String? take,
  });
}

class EdgeDataSourceImpl implements EdgeDataSource {
  final ApiClient client;

  EdgeDataSourceImpl(this.client);
  @override
  Future<String> create(Map<String, dynamic> object) async {
    final responce = await client.post(
        ApiConstants.baseUrl + ApiConstants.buildings + ApiConstants.edges,
        body: object);
    return jsonDecode(responce.body)["EdgeIds"][0];
  }

  @override
  Future<void> delete(String guid) async {
    await client.delete(ApiConstants.baseUrl + ApiConstants.buildings + ApiConstants.edges + guid);
  }

  @override
  Future<EdgeModel> get(String guid) async {
    var responce =
        await client.get(ApiConstants.baseUrl + ApiConstants.edges + guid);
    return EdgeModel.fromJson(jsonDecode(responce.body));
  }

  @override
  Future<List<EdgeModel>> getMany({
    String? buildingid,
    String? fromBuildingObjectId,
    String? toBuildingObjectId,
    int? floorNumber,
    String? skip,
    String? take,
  }) async {
    var uri =
        ApiConstants.baseUrl + ApiConstants.buildings + ApiConstants.edges;
    var querys = [
      if (buildingid != null) "BuildingId=$buildingid",
      if (fromBuildingObjectId != null)
        "FromBuildingObjectId=$fromBuildingObjectId",
      if (toBuildingObjectId != null) "ToBuildingObjectId=$toBuildingObjectId",
      if (floorNumber != null) "FloorNumber=$floorNumber",
      if (skip != null) "Skip=$skip",
      if (take != null) "Take=$take",
    ];
    if (querys.isNotEmpty) {
      uri += "?${querys.join("&")}";
    }
    var responce = await client.get(uri);
    return List<EdgeModel>.from(
        jsonDecode(responce.body).map((x) => EdgeModel.fromJson(x)));
  }
}
