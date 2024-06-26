import 'package:equatable/equatable.dart';

import '../../core/building_object_type.dart';

class Waypoint extends Equatable {
  const Waypoint({
    required this.id,
    required this.buildingId,
    required this.title,
    required this.description,
    required this.floor,
    required this.type,
    required this.x,
    required this.y,
    this.keywords,
  });

  final String id;
  final String buildingId;
  final String? title;
  final String? description;
  final int floor;
  final BuildingObjectType type;
  final double x;
  final double y;
  final String? keywords;

  @override
  List<Object?> get props =>
      [id, buildingId, title, description, floor, type, x, y];
}
