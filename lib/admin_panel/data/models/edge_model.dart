import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';

import 'package:json_annotation/json_annotation.dart';

part 'edge_model.g.dart';

@JsonSerializable()
class EdgeModel extends Edge {
  const EdgeModel({
    required super.from,
    required super.to,
    required super.id,
    required super.buildingId,
    required super.floorNumber,
  });

  factory EdgeModel.fromJson(Map<String, dynamic> json) =>
      _$EdgeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EdgeModelToJson(this);
}
