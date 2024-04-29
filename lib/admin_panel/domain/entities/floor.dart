import 'package:equatable/equatable.dart';

import 'edge.dart';
import 'waypoint.dart';

class Floor extends Equatable {
  final String buildingId;
  final int floorNumber;
  final List<Waypoint> waypoints;
  final List<Edge> edges;
  final String imageLink;

  const Floor(
      {required this.buildingId,
      required this.floorNumber,
      required this.waypoints,
      required this.edges,
      required this.imageLink});

  @override
  List<Object?> get props =>
      [buildingId, floorNumber, waypoints, edges, imageLink];
}
