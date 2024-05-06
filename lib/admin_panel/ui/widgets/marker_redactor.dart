import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/admin_panel_bloc/admin_panel_bloc_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/map_edit_bloc/map_edit_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/wapoint_create_form.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/waypoint.dart';

class MarkerRedactor extends StatefulWidget {
  const MarkerRedactor(
      {Key? key, required this.floorImage, required this.floor})
      : super(key: key);
  final Image floorImage;
  final Floor floor;

  @override
  State<MarkerRedactor> createState() => _MarkerRedactorState();
}

class _MarkerRedactorState extends State<MarkerRedactor> {
  var newEdgeStart = Offset.zero;
  var newEdgeEnd = Offset.zero;
  Waypoint? selectedPoint;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminPanelBloc, AdminPanelState>(
      listener: (context, state) {
        if (state is Loaded) {
          BlocProvider.of<MapEditBloc>(context).add(InitFloors(state.floors));
        }
      },
      child: Stack(
        children: [
          widget.floorImage,
          Positioned.fill(
            child: BlocBuilder<MapEditBloc, MapEditState>(
              builder: (context, state) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    var size = constraints.biggest;
                    if (state is MapLoaded &&
                        state.floors.length >= widget.floor.floorNumber - 1) {
                      return Listener(
                        behavior: HitTestBehavior.translucent,
                        onPointerDown: (event) async {
                          if (event.buttons == kPrimaryMouseButton &&
                              state.editMode == MapEditMode.createObject) {
                            Waypoint? waypoint = await showDialog(
                              context: context,
                              builder: (context) {
                                return const WaypointCreateForm();
                              },
                            );
                            if (waypoint != null && mounted) {
                              BlocProvider.of<MapEditBloc>(context)
                                  .add(AddWaypoint(
                                Waypoint(
                                  id: '',
                                  buildingId: widget.floor.buildingId,
                                  title: waypoint.title,
                                  description: waypoint.description,
                                  floor: widget.floor.floorNumber,
                                  type: waypoint.type,
                                  x: event.localPosition.dx / size.width,
                                  y: event.localPosition.dy / size.height,
                                ),
                              ));
                            }
                          }
                        },
                        child: Stack(
                          children: [
                            CustomPaint(
                              size: size,
                              painter: EdgePainter(
                                lines: [
                                  ...state
                                      .floors[widget.floor.floorNumber - 1].$2,
                                  // (newEdgeStart, newEdgeEnd),
                                ],
                              ),
                            ),
                            ...state.floors[widget.floor.floorNumber - 1].$1
                                .map(
                              (e) => Positioned(
                                left: e.x * size.width - 20,
                                top: e.y * size.height - 40,
                                child: GestureDetector(
                                  onTap: () {
                                    if (state.editMode ==
                                            MapEditMode.createEdge &&
                                        selectedPoint != e) {
                                      if (selectedPoint == null) {
                                        setState(() {
                                          selectedPoint = e;
                                        });
                                      } else {
                                        BlocProvider.of<MapEditBloc>(context)
                                            .add(
                                          AddEdge(
                                            selectedPoint!.id,
                                            e.id,
                                            widget.floor.floorNumber,
                                          ),
                                        );
                                        selectedPoint = null;
                                      }
                                    }
                                    if (state.editMode ==
                                        MapEditMode.deleteObject) {
                                      BlocProvider.of<MapEditBloc>(context)
                                          .add(DeleteWaypoint(e));
                                    }
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: WaypointView(
                                    waypoint: e,
                                    color: selectedPoint == e
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const Placeholder();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EdgePainter extends CustomPainter {
  final List<(Offset, Offset)> lines;

  EdgePainter({super.repaint, required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    for (var line in lines) {
      var from = Offset(line.$1.dx * size.width, line.$1.dy * size.height);
      var to = Offset(line.$2.dx * size.width, line.$2.dy * size.height);
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
