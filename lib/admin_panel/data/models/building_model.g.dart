// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      floorNumbers: (json['floorNumbers'] as num).toInt(),
      floors: (json['floors'] as List<dynamic>)
          .map((e) => FloorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'floorNumbers': instance.floorNumbers,
      'floors': instance.floors,
      'description': instance.description,
    };
