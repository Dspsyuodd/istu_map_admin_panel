import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../domain/entities/edge.dart';
import '../../domain/entities/floor.dart';
import '../../domain/entities/waypoint.dart';
import '../../domain/usecases/edge_usecases.dart';
import '../../domain/usecases/waypoint_usecases.dart';

part 'map_edit_event.dart';
part 'map_edit_state.dart';

class MapEditBloc extends Bloc<MapEditEvent, MapEditState> {
  final WaypointUsecases _waypointUsecases;
  final EdgeUsecases _edgeUsecases;
  var _floors = <Floor>[];
  var _mode = MapEditMode.createObject;

  MapEditBloc(this._waypointUsecases, this._edgeUsecases)
      : super(MapEditInitial()) {
    on<MapEditEvent>((event, emit) async {
      print(event.runtimeType);
      if (event is InitFloors) {
        emit(MapLoading());
        _floors = event.floors;
        emit(MapLoaded(_floors.map((e) => floorToMapData(e)).toList(), _mode));
      }
      if (event is AddWaypoint) {
        emit(MapLoading());
        var result = await _waypointUsecases.create(event.waypoint);
        result.fold((l) => _emitError(l, emit), (r) {
          _floors[event.waypoint.floor - 1].waypoints.add(
                Waypoint(
                  id: r,
                  buildingId: event.waypoint.buildingId,
                  title: event.waypoint.title,
                  description: event.waypoint.description,
                  floor: event.waypoint.floor,
                  type: event.waypoint.type,
                  x: event.waypoint.x,
                  y: event.waypoint.y,
                ),
              );
          emit(
              MapLoaded(_floors.map((e) => floorToMapData(e)).toList(), _mode));
        });
      }
      if (event is ChangeEditMode) {
        emit(MapLoading());
        _mode = event.editMode;
        emit(MapLoaded(_floors.map((e) => floorToMapData(e)).toList(), _mode));
      }

      if (event is AddEdge) {
        emit(MapLoading());
        var edge = Edge(id: '', fromId: event.fromId, toId: event.toId);
        var result = await _edgeUsecases.create(edge);
        result.fold(
          (l) => _emitError(l, emit),
          (r) {
            _floors[event.floorNumber - 1].edges.add(edge);
            emit(MapLoaded(
                _floors.map((e) => floorToMapData(e)).toList(), _mode));
          },
        );
      }

      if (event is DeleteWaypoint) {
        emit(MapLoading());
        var responce = await _waypointUsecases.delete(event.waypoint.id);

        await responce.fold(
          (l) async => _emitError(l, emit),
          (r) async {
            var edgesEither = await _edgeUsecases.getMany(
              buildingid: event.waypoint.buildingId,
              floorNumber: event.waypoint.floor,
            );
            _floors[event.waypoint.floor - 1].waypoints.remove(event.waypoint);
            edgesEither.fold(
              (l) => _emitError(l, emit),
              (r) {
                _floors[event.waypoint.floor - 1].edges.clear();
                _floors[event.waypoint.floor - 1].edges.addAll(r);
                emit(MapLoaded(
                    _floors.map((e) => floorToMapData(e)).toList(), _mode));
              },
            );
          },
        );
      }
    });
  }

  void _emitError(Failure l, Emitter<MapEditState> emit) {
    if (l is ServerFailure) {
      emit(MapServerError(
        message: l.message,
        code: l.code.toString(),
      ));
    }
    if (l is ConnectionFailure) {}
    if (l is UnknownFailure) {
      emit(
        MapUnknownError(
          message: l.message,
          stackTrace: l.stackTrace,
        ),
      );
    }
  }

  (List<Waypoint> waypoints, List<(Offset x, Offset y)> edges) floorToMapData(
      Floor floor) {
    var edges = <(Offset, Offset)>[];
    var waypointMap = <String, Waypoint>{};
    for (var waypoint in floor.waypoints) {
      waypointMap[waypoint.id] = waypoint;
    }
    for (var edge in floor.edges) {
      var from = waypointMap[edge.fromId];
      var to = waypointMap[edge.toId];

      if (from != null && to != null) {
        edges.add((Offset(from.x, from.y), Offset(to.x, to.y)));
      }
    }
    return (floor.waypoints, edges);
  }
}

enum MapEditMode {
  createObject._("Создать объект"),
  createEdge._("Создать ребро"),
  deleteObject._("Удалить объект");

  final String name;

  const MapEditMode._(this.name);
}
