import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/admin_panel_bloc/admin_panel_bloc_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/widgets/marker_redactor.dart';
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
                                  (e) => MarkerRedactor(
                                    floorImage: Image.asset('t9H6ZPGTNvc.jpg'),
                                    floor: e,
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
