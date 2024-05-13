// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: json['Id'] as String,
      title: json['Title'] as String,
      floors: (json['Floors'] as List<dynamic>)
          .map((e) => FloorInfoModel.fromJson(e as Map<String, dynamic>) as FloorInfo)
          .toList(),
      description: json['Description'] as String?,
      address: json['Address'] as String,
      latitude: (json['Latitude'] as num).toDouble(),
      longitude: (json['Longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Title': instance.title,
      'Floors': instance.floors,
      'Description': instance.description,
      'Address': instance.address,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
    };

FloorInfoModel _$FloorInfoModelFromJson(Map<String, dynamic> json) =>
    FloorInfoModel(
      floorNumber: (json['FloorNumber'] as num).toInt(),
      imageLink: json['ImageLink'] as String?,
    );

Map<String, dynamic> _$FloorInfoModelToJson(FloorInfoModel instance) =>
    <String, dynamic>{
      'FloorNumber': instance.floorNumber,
      'ImageLink': instance.imageLink,
    };
