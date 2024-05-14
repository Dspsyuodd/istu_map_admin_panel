import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../admin_panel_bloc/admin_panel_bloc_bloc.dart';
import 'marker_redactor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BuildingMap extends StatefulWidget {
  const BuildingMap({Key? key}) : super(key: key);

  @override
  State<BuildingMap> createState() => _BuildingMapState();
}

class _BuildingMapState extends State<BuildingMap> {
  var offset = Offset.zero;
  var mousePos = Offset.zero;
  var scale = 1.0;
  void _onPointerMove(PointerMoveEvent details) {
    if (details.buttons == kMiddleMouseButton) {
      setState(() {
        offset += details.delta;
      });
    }
  }

  void _onPointerHover(PointerHoverEvent event) {
    mousePos = event.localPosition;
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        var scaleDelta = 1 - event.scrollDelta.dy * 0.001;
        scale *= scaleDelta;
        var height = MediaQuery.of(context).size.height - 70;
        offset +=
            (mousePos - offset - Offset(0, height) / 2) * (1 - scaleDelta);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      onPointerHover: _onPointerHover,
      onPointerMove: _onPointerMove,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Opacity(
            opacity: 0.05,
            child: Image.asset(
              'istu_logo_black.png',
              repeat: ImageRepeat.repeat,
              scale: 6,
            ),
          )),
          OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: Stack(
              children: [
                Transform.translate(
                  offset: offset,
                  child: Transform.scale(
                    alignment: Alignment.centerLeft,
                    scale: scale,
                    child: BlocBuilder<AdminPanelBloc, AdminPanelState>(
                      builder: (context, state) {
                        if (state is Loading) {
                          return LoadingAnimationWidget.waveDots(
                              color: Colors.blue, size: 50);
                        }
                        if (state is Loaded) {
                          return Column(
                            children: state.floors
                                .map(
                                  (e) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MarkerRedactor(
                                        floorImage: e.image ??
                                            Image.asset('t9H6ZPGTNvc.jpg'),
                                        floor: e,
                                      ),
                                      IconButton(
                                        color: Colors.green,
                                        iconSize: 50,
                                        onPressed: () {},
                                        icon: const Icon(Icons.settings),
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        iconSize: 50,
                                        onPressed: () {
                                          BlocProvider.of<AdminPanelBloc>(
                                                  context)
                                              .add(DeleteFloor(e));
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          );
                        }
                        return const Placeholder(
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: Center(
                              child: Text(
                                'Placeholder',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
