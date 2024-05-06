import 'dart:convert';

import '../../constants/api_constants.dart';
import '../../core/api_client.dart';
import '../models/building_model.dart';

abstract interface class BuildingDataSource {
  Future<String> create(Map<String, dynamic> object);
  Future<void> delete(String guid);
  Future<BuildingModel> get(String guid);
  Future<List<BuildingModel>> getAll();
  Future<void> update(Map<String, dynamic> object);
}

class BuildingDataSourceImpl implements BuildingDataSource {
  final ApiClient client;

  BuildingDataSourceImpl(this.client);

  @override
  Future<String> create(Map<String, dynamic> object) async {
    var result = (await client.post(ApiConstants.baseUrl + ApiConstants.buildings,
            body: object));
    return jsonDecode(result.body)["BuildingId"];
  }

  @override
  Future<void> delete(String guid) async {
    await client.delete(ApiConstants.baseUrl + ApiConstants.buildings + guid);
  }

  @override
  Future<BuildingModel> get(String guid) async {
    var responce =
        await client.get(ApiConstants.baseUrl + ApiConstants.buildings + guid);
    return BuildingModel.fromJson(jsonDecode(responce.body));
  }

  @override
  Future<List<BuildingModel>> getAll() async {
    var responce =
        await client.get(ApiConstants.baseUrl + ApiConstants.buildings);
    return List<BuildingModel>.from(
        jsonDecode(responce.body).map((x) => BuildingModel.fromJson(x)));
  }

  @override
  Future<void> update(Map<String, dynamic> object) async {
    await client.post(ApiConstants.baseUrl + ApiConstants.buildings + object['Id']!,
        body: object);
  }
}
