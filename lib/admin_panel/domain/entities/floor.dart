import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'edge.dart';
import 'waypoint.dart';

class Floor extends Equatable{
  final String buildingId;
  final String id;
  final int floorNumber;
  final List<Waypoint> waypoints;
  final List<Edge> edges;
  final String? imageId;
  final Image? image;

  const Floor({
    required this.id,
    required this.buildingId,
    required this.floorNumber,
    required this.waypoints,
    required this.edges,
    this.imageId,
    this.image,
  });

  @override
  List<Object?> get props =>
      [buildingId, floorNumber, waypoints, edges, id, imageId];
}
