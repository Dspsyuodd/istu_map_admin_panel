// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EdgeModel _$EdgeModelFromJson(Map<String, dynamic> json) => EdgeModel(
      id: '',
      fromId: json['FromId'] as String,
      toId: json['ToId'] as String,
    );

Map<String, dynamic> _$EdgeModelToJson(EdgeModel instance) => <String, dynamic>{
      'id': instance.id,
      'from': instance.fromId,
      'to': instance.toId,
    };
