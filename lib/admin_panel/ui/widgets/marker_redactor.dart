import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/core/building_object_type.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/bloc/admin_panel_bloc_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/waypoint.dart';

class MarkerRedactor extends StatefulWidget {
  const MarkerRedactor({Key? key, required this.floorImage}) : super(key: key);
  final Image floorImage;

  @override
  State<MarkerRedactor> createState() => _MarkerRedactorState();
}

class _MarkerRedactorState extends State<MarkerRedactor> {
  var waypoints = <Waypoint>[
    const Waypoint(
      id: "",
      buildingId: "buildingId",
      title: "title",
      description: "description",
      floor: 1,
      type: BuildingObjectType.auditorium,
      x: 0.1,
      y: 0.9,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPanelBloc, AdminPanelState>(
      builder: (context, state) {
        if (state is Loading) {
          return Container();
        }
        if (state is Error) {
          return Container();
        }
        if (state is Loaded) {
          return Stack(
            children: [
              widget.floorImage,
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    var size = constraints.biggest;
                    return Stack(children: [
                      ...waypoints.map(
                        (e) => Positioned(
                          left: e.x * size.width,
                          top: e.y * size.height,
                          child: WaypointView(
                            waypoint: e,
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ],
          );
        }

        return const Placeholder(
          child: SizedBox(
            width: 500,
            height: 500,
            child: Center(child: Text('Placeholder')),
          ),
        );
      },
    );
  }
}
