import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/image_usecases.dart';
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
  final ImageUsecases imageUsecases;
  var buildings = <Building>[];
  var floors = <Floor>[];
  int? selectedBuilding;

  AdminPanelBloc(this.buildingUseCases, this.floorUseCases, this.imageUsecases)
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
        await _selectBuilding(emit, event);
      }
      if (event is AddFloor && selectedBuilding != null) {
        await _addFloor(emit, event);
      }
      if (event is DeleteFloor) {
        var result = await floorUseCases.delete(event.floor);
        result.fold(
          (l) => _emitError(l, emit),
          (r) {
            floors.removeWhere(
              (element) => element.id == event.floor.id,
            );
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
    });
  }

  Future<void> _addFloor(Emitter<AdminPanelState> emit, AddFloor event) async {
    emit(Loading());
    var floor = Floor(
      id: event.floorInfo.floorId,
      buildingId: buildings[selectedBuilding!].id,
      floorNumber: buildings[selectedBuilding!].floors.length + 1,
      waypoints: List.empty(growable: true),
      edges: List.empty(growable: true),
    );
    var result = await floorUseCases.create(floor, event.image);
    buildings[selectedBuilding!].floors.add(
          FloorInfo(
            floorNumber: buildings[selectedBuilding!].floors.length + 1,
            floorId: event.floorInfo.floorId,
          ),
        );
    String? imageId;
    Image? image;
    await result.$2?.fold(
      (l) async => _emitError(l, emit),
      (r) async {
        imageId = r;
        var imageRes = await imageUsecases.getImage(imageId!);
        imageRes.fold(
          (l) => _emitError(l, emit),
          (r) => image = r,
        );
      },
    );
    result.$1.fold(
      (l) => _emitError(l, emit),
      (r) {
        floors.add(
          Floor(
            id: r,
            buildingId: floor.buildingId,
            floorNumber: floor.floorNumber,
            waypoints: floor.waypoints,
            edges: floor.edges,
            imageId: imageId,
            image: image,
          ),
        );
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
    await result.fold(
      (l) async => _emitError(l, emit),
      (r) async {
        floors = [];
        for (var floor in r) {
          var imageRes = await imageUsecases.getImageByObjectId(floor.id);
          Image? image;
          imageRes.fold(
            (l2) => _emitError(l2, emit),
            (r2) {
              image = r2.firstOrNull;
            },
          );
          floors.add(Floor(
            id: floor.id,
            buildingId: floor.buildingId,
            floorNumber: floor.floorNumber,
            waypoints: floor.waypoints,
            edges: floor.edges,
            imageId: floor.imageId,
            image: image,
          ));
        }
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
