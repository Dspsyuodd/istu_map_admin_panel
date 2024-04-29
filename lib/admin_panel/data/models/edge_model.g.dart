// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdgeModel _$EdgeModelFromJson(Map<String, dynamic> json) => EdgeModel(
      from: json['from'] as String,
      to: json['to'] as String,
      id: json['id'] as String,
      buildingId: json['buildingId'] as String,
      floorNumber: (json['floorNumber'] as num).toInt(),
    );

Map<String, dynamic> _$EdgeModelToJson(EdgeModel instance) => <String, dynamic>{
      'id': instance.id,
      'buildingId': instance.buildingId,
      'floorNumber': instance.floorNumber,
      'from': instance.from,
      'to': instance.to,
    };
