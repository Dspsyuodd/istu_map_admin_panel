import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/floor.dart';
import 'edge_model.dart';
import 'waypoint_model.dart';

part 'floor_model.g.dart';

@JsonSerializable()
class FloorModel extends Floor {
  const FloorModel(
      {required super.buildingId,
      required super.floorNumber,
      required super.waypoints,
      required super.edges,
      required super.imageLink});

  factory FloorModel.fromJson(Map<String, dynamic> json) => _$FloorModelFromJson(json);

  Map<String, dynamic> toJson() => _$FloorModelToJson(this);
}
