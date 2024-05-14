// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) => FloorModel(
      id: json['FloorId'] as String,
      buildingId: json['BuildingId'] as String,
      floorNumber: (json['FloorNumber'] as num).toInt(),
      waypoints: (json['Objects'] as List<dynamic>)
          .map((e) =>
              WaypointModel.fromJson(e as Map<String, dynamic>) as Waypoint)
          .toList(),
      edges: (json['Edges'] as List<dynamic>)
          .map((e) => EdgeModel.fromJson(e as Map<String, dynamic>) as Edge)
          .toList(),
    );

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'BuildingId': instance.buildingId,
      'FloorNumber': instance.floorNumber,
      'Objects': instance.waypoints,
      'Edges': instance.edges,
    };
