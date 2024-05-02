import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/building.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/building_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/edge_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/floor_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/waypoint_usecases.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';

part 'admin_panel_bloc_event.dart';
part 'admin_panel_bloc_state.dart';

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  final BuildingUseCases buildingUseCases;
  final FloorUsecases floorUseCases;
  final EdgeUsecases edgeUsecases;
  final WaypointUsecases waypointUsecases;
  var buildings = <Building>[];
  var floors = <Floor>[];
  var waypoints = <Waypoint>[];
  var edges = <Edge>[];
  int? selectedBuilding;

  AdminPanelBloc(this.buildingUseCases, this.floorUseCases, this.edgeUsecases,
      this.waypointUsecases)
      : super(Empty()) {
    on<AdminPanelEvent>((event, emit) async {
      log(event.runtimeType.toString());
      if (event is AddBuilding) {
        await _addBuilding(emit, event);
      }
      if (event is GetBuildings) {
        await _getBuildings(emit);
      }
      if (event is SelectBuilding) {
        _selectBuilding(emit, event);
      }
      if (event is AddFloor && selectedBuilding != null) {
        emit(Loading());
        var result = await floorUseCases.create(
          Floor(
            buildingId: buildings[selectedBuilding!].id,
            floorNumber: buildings[selectedBuilding!].floors.length + 1,
            waypoints: const [],
            edges: const [],
            imageLink: event.floorInfo.imageLink,
          ),
        );
        result.fold(
          (l) => _emitError(l, emit),
          (r) {
            emit(
              Loaded(
                selectedBuildingIndex: selectedBuilding,
                buildings: buildings,
                floors: floors,
                waypoints: waypoints,
                edges: edges,
              ),
            );
          },
        );
      }
    });
  }

  Future<void> _selectBuilding(
      Emitter<AdminPanelState> emit, SelectBuilding event) async {
    selectedBuilding = event.index;

    var result = await floorUseCases.getAll(buildings[selectedBuilding!].id);

    result.fold(
      (l) => _emitError(l, emit),
      (r) {
        floors = r;
      },
    );

    emit(
      Loaded(
        selectedBuildingIndex: selectedBuilding,
        buildings: buildings,
        floors: floors,
        waypoints: waypoints,
        edges: edges,
      ),
    );
  }

  Future<void> _getBuildings(Emitter<AdminPanelState> emit) async {
    emit(Loading());
    var result = await buildingUseCases.getAll();
    result.fold((l) {
      _emitError(l, emit);
    }, (r) {
      buildings = r;
      emit(
        Loaded(
          selectedBuildingIndex: 0,
          buildings: buildings,
          floors: floors,
          waypoints: waypoints,
          edges: edges,
        ),
      );
    });
  }

  Future<void> _emitError(Failure l, Emitter<AdminPanelState> emit) async {
    if (l is ServerFailure) {
      emit(ServerError(
        message: l.message,
        code: l.code.toString(),
      ));
    }
    if (l is ConnectionFailure) {}
    if (l is UnknownFailure) {
      emit(
        UnknownError(
          message: l.message,
          stackTrace: l.stackTrace,
        ),
      );
    }
  }

  Future<void> _addBuilding(
      Emitter<AdminPanelState> emit, AddBuilding event) async {
    emit(Loading());
    var result = await buildingUseCases.create(event.building);
    result.fold(
      (l) {
        _emitError(l, emit);
        emit(
          Loaded(
            selectedBuildingIndex: 0,
            buildings: buildings,
            floors: floors,
            waypoints: waypoints,
            edges: edges,
          ),
        );
      },
      (r) {
        var newBuilding = Building(
          id: r,
          title: event.building.title,
          floors: const [],
          description: event.building.description,
          address: event.building.address,
          latitude: event.building.latitude,
          longitude: event.building.longitude,
        );
        buildings.add(newBuilding);
        emit(
          Loaded(
            selectedBuildingIndex: 0,
            buildings: buildings,
            floors: floors,
            waypoints: waypoints,
            edges: edges,
          ),
        );
      },
    );
  }
}
