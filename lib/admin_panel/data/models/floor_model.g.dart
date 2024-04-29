// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) => FloorModel(
      buildingId: json['buildingId'] as String,
      floorNumber: (json['floorNumber'] as num).toInt(),
      waypoints: (json['waypoints'] as List<dynamic>)
          .map((e) => WaypointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List<dynamic>)
          .map((e) => EdgeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageLink: json['imageLink'] as String,
    );

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      'buildingId': instance.buildingId,
      'floorNumber': instance.floorNumber,
      'waypoints': instance.waypoints,
      'edges': instance.edges,
      'imageLink': instance.imageLink,
    };
