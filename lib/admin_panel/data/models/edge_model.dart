import '../../domain/entities/edge.dart';

import 'package:json_annotation/json_annotation.dart';

part 'edge_model.g.dart';

@JsonSerializable()
class EdgeModel extends Edge {
  const EdgeModel({
    required super.fromId,
    required super.toId,
    required super.id,
  });

  factory EdgeModel.fromJson(Map<String, dynamic> json) =>
      _$EdgeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EdgeModelToJson(this);
}
