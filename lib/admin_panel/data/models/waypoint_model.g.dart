// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaypointModel _$WaypointModelFromJson(Map<String, dynamic> json) =>
    WaypointModel(
      id: json['id'] as String,
      buildingId: json['buildingId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      floor: (json['floor'] as num).toInt(),
      type: $enumDecode(_$BuildingObjectTypeEnumMap, json['type']),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$WaypointModelToJson(WaypointModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buildingId': instance.buildingId,
      'title': instance.title,
      'description': instance.description,
      'floor': instance.floor,
      'type': _$BuildingObjectTypeEnumMap[instance.type]!,
      'x': instance.x,
      'y': instance.y,
    };

const _$BuildingObjectTypeEnumMap = {
  BuildingObjectType.node: 'node',
  BuildingObjectType.auditorium: 'auditorium',
  BuildingObjectType.cabinet: 'cabinet',
  BuildingObjectType.toilet: 'toilet',
  BuildingObjectType.cafe: 'cafe',
  BuildingObjectType.ladder: 'ladder',
  BuildingObjectType.elevator: 'elevator',
  BuildingObjectType.entrance: 'entrance',
};
