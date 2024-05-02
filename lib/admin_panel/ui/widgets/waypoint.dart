import 'package:flutter/material.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';

class WaypointView extends StatelessWidget {
  const WaypointView({Key? key, required this.waypoint}) : super(key: key);
  final Waypoint waypoint;
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.location_on, size: 40,);
  }
}
