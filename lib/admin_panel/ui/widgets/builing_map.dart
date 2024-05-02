import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/bloc/admin_panel_bloc_bloc.dart';
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
    setState(() {
      offset += details.delta;
    });
  }

  void _onPointerHover(PointerHoverEvent event) {
    mousePos = event.localPosition;
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        var scaleDelta = 1 - event.scrollDelta.dy * 0.001;
        scale *= scaleDelta;
        offset += (mousePos - offset) * (1 - scaleDelta);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Image.asset(
                'istu_logo_black.png',
                repeat: ImageRepeat.repeat,
                scale: 6,
              ),
            )),
        OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Listener(
            onPointerMove: _onPointerMove,
            onPointerSignal: _onPointerSignal,
            onPointerHover: _onPointerHover,
            child: Stack(
              children: [
                Transform.translate(
                  offset: offset,
                  child: Transform(
                    transform: Matrix4.identity()..scale(scale),
                    child: BlocBuilder<AdminPanelBloc, AdminPanelState>(
                      builder: (context, state) {
                        if (state is Loading) {
                          return LoadingAnimationWidget.waveDots(
                              color: Colors.blue, size: 50);
                        }
                        if (state is Loaded) {
                          return Column(
                            children: state.floors
                                .map((e) => MarkerRedactor(
                                    floorImage: Image.asset('t9H6ZPGTNvc.jpg')))
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
        ),
      ],
    );
  }
}
