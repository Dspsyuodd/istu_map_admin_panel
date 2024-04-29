import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/building_object_type.dart';

part 'waypoint_model.g.dart';

@JsonSerializable()
class WaypointModel extends Waypoint {
  const WaypointModel({required super.id, required super.buildingId, required super.title, required super.description, required super.floor, required super.type, required super.x, required super.y});

  factory WaypointModel.fromJson(Map<String, dynamic> json) => _$WaypointModelFromJson(json);

  Map<String, dynamic> toJson() => _$WaypointModelToJson(this);
}