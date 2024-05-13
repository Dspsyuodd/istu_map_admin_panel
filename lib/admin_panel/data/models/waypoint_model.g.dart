// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaypointModel _$WaypointModelFromJson(Map<String, dynamic> json) =>
    WaypointModel(
      id: json['Id'] as String,
      buildingId: json['BuildingId'] as String,
      title: json['Title'] as String?,
      description: json['Description'] as String?,
      floor: (json['Floor'] as num).toInt(),
      type: BuildingObjectType.values[json['Type'] as int],
      x: (json['X'] as num).toDouble(),
      y: (json['Y'] as num).toDouble(),
    );

Map<String, dynamic> _$WaypointModelToJson(WaypointModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'BuildingId': instance.buildingId,
      'Title': instance.title,
      'Description': instance.description,
      'Floor': instance.floor,
      'Type': _$BuildingObjectTypeEnumMap[instance.type]!,
      'X': instance.x,
      'Y': instance.y,
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
