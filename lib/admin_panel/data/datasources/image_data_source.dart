import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:istu_map_admin_panel/admin_panel/constants/api_constants.dart';
import 'package:istu_map_admin_panel/admin_panel/core/api_client.dart';

abstract interface class ImageDataSource {
  Future<String> addImage(String objectId, File image);
  Future<Image> getImage(String imageId);
  Future<List<String>> getImageByObjectId(String objectId);
}

class ImageDataSourceImpl implements ImageDataSource {
  final ApiClient client;

  ImageDataSourceImpl(this.client);

  @override
  Future<String> addImage(objectId, image) async {
    final responce = await client.multipartRequest(
      ApiConstants.baseUrl +
          ApiConstants.images +
          ApiConstants.upload +
          objectId,
      image,
    );
    return responce.body.substring(1, responce.body.length - 1);
  }

  @override
  Future<Image> getImage(imageId) async {
    final response = await client.get(
      ApiConstants.baseUrl +
          ApiConstants.images +
          ApiConstants.download +
          imageId,
    );
    return Image.memory(response.bodyBytes);
  }

  @override
  Future<List<String>> getImageByObjectId(objectId) async {
    final response = await client.get(
      ApiConstants.baseUrl + ApiConstants.images + objectId,
    );
    return List<String>.from(jsonDecode(response.body)["Images"].map((e) => e["Id"] as String));
  }
}
