import 'dart:convert';

import '../../constants/api_constants.dart';
import '../../core/api_client.dart';
import '../models/floor_model.dart';

abstract interface class FloorDataSource {
  Future<String> create(String buildingId, Map<String, dynamic> object);
  Future<void> delete(String buildingId, int floorNumber);
  Future<FloorModel> get(String guid);
  Future<List<FloorModel>> getAll(String buildingId);
  Future<void> update(String buildingId, Map<String, dynamic> object);
}

class FloorDataSourceImpl implements FloorDataSource {
  final ApiClient client;

  FloorDataSourceImpl(this.client);
  @override
  Future<String> create(String buildingId, Map<String, dynamic> object) async {
    final responce = await client.post(
        '${ApiConstants.baseUrl + ApiConstants.buildings}$buildingId/${ApiConstants.floors}',
        body: object);
    return jsonDecode(responce.body)["FloorId"];
  }

  @override
  Future<void> delete(buildingId, floorNumber) async {
    await client.delete(
      ApiConstants.baseUrl +
          ApiConstants.buildings +
          buildingId +
          ApiConstants.floors +
          floorNumber.toString(),
    );
  }

  @override
  Future<FloorModel> get(String guid) async {
    final responce = await client.get(ApiConstants.baseUrl +
        ApiConstants.buildings +
        ApiConstants.floors +
        guid);
    return FloorModel.fromJson(jsonDecode(responce.body));
  }

  @override
  Future<List<FloorModel>> getAll(String buildingId) async {
    final responce = await client.get(
        '${ApiConstants.baseUrl}${ApiConstants.buildings}$buildingId/${ApiConstants.floors}');
    return List<FloorModel>.from(
      jsonDecode(responce.body).map(
        (x) => FloorModel.fromJson(x),
      ),
    );
  }

  @override
  Future<void> update(String buildingId, Map<String, dynamic> object) async {
    await client.post(
        '${ApiConstants.baseUrl + ApiConstants.buildings}${ApiConstants.floors}$buildingId/',
        body: object);
  }
}
