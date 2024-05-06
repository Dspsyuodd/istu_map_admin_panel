import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/building.dart';
import '../../domain/entities/floor.dart';
import '../../domain/usecases/building_usecases.dart';
import '../../domain/usecases/floor_usecases.dart';
import '../../../core/errors/failure.dart';

part 'admin_panel_bloc_event.dart';
part 'admin_panel_bloc_state.dart';

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  final BuildingUseCases buildingUseCases;
  final FloorUsecases floorUseCases;
  var buildings = <Building>[];
  var floors = <Floor>[];
  int? selectedBuilding;

  AdminPanelBloc(this.buildingUseCases, this.floorUseCases) : super(Empty()) {
    on<AdminPanelEvent>((event, emit) async {
      log(event.runtimeType.toString());
      if (event is AddBuilding) {
        await _addBuilding(emit, event);
      }
      if (event is GetBuildings) {
        await _getBuildings(emit);
      }
      if (event is SelectBuilding) {
        await _selectBuilding(emit, event);
      }
      if (event is AddFloor && selectedBuilding != null) {
        await _addFloor(emit, event);
      }
    });
  }

  Future<void> _addFloor(Emitter<AdminPanelState> emit, AddFloor event) async {
    emit(Loading());
    var floor = Floor(
      buildingId: buildings[selectedBuilding!].id,
      floorNumber: buildings[selectedBuilding!].floors.length + 1,
      waypoints: List.empty(growable: true),
      edges: List.empty(growable: true),
      imageLink: event.floorInfo.imageLink,
    );
    var result = await floorUseCases.create(floor);
    buildings[selectedBuilding!].floors.add(FloorInfo(
          floorNumber: buildings[selectedBuilding!].floors.length + 1,
          imageLink: event.floorInfo.imageLink,
        ));
    result.fold(
      (l) => _emitError(l, emit),
      (r) {
        floors.add(floor);
        emit(
          Loaded(
            selectedBuildingIndex: selectedBuilding,
            buildings: buildings,
            floors: floors,
          ),
        );
      },
    );
  }

  Future<void> _selectBuilding(
      Emitter<AdminPanelState> emit, SelectBuilding event) async {
    emit(Loading());
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
          selectedBuildingIndex: selectedBuilding,
          buildings: buildings,
          floors: floors,
        ),
      );
    });
  }

  void _emitError(Failure l, Emitter<AdminPanelState> emit) {
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
          ),
        );
      },
    );
  }
}
