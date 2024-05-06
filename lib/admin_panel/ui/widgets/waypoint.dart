import 'package:flutter/material.dart';
import '../../core/building_object_type.dart';
import '../../domain/entities/waypoint.dart';

class WaypointView extends StatefulWidget {
  const WaypointView({Key? key, required this.waypoint, this.color})
      : super(key: key);
  final Waypoint waypoint;
  final Color? color;

  @override
  State<WaypointView> createState() => _WaypointViewState();
}

class _WaypointViewState extends State<WaypointView> {
  var scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      opaque: false,
      onEnter: (event) {
        setState(() {
          scale = 1.2;
        });
      },
      onExit: (event) {
        setState(() {
          scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Icon(
          _getIcon(),
          size: 40,
          color: widget.color,
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (widget.waypoint.type) {
      case BuildingObjectType.auditorium:
        return Icons.school;

      case BuildingObjectType.cabinet:
        return Icons.person_pin_circle;

      case BuildingObjectType.cafe:
        return Icons.dining;

      case BuildingObjectType.toilet:
        return Icons.wc;

      case BuildingObjectType.entrance:
        return Icons.door_front_door;

      case BuildingObjectType.node:
        return Icons.location_on;

      case BuildingObjectType.ladder:
        return Icons.stairs;

      case BuildingObjectType.elevator:
        return Icons.elevator;

      default:
        return Icons.location_on;
    }
  }
}
