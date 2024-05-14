import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/errors/failure.dart';
import '../entities/building.dart';
import '../entities/edge.dart';
import '../entities/floor.dart';
import '../entities/waypoint.dart';
import 'istu_map_repository.dart';

abstract interface class BuildingRepository
    implements IstuMapRepository<Building> {
  Future<Either<Failure, void>> update(Building object);
  Future<Either<Failure, List<Building>>> getAll();
}

abstract interface class FloorRepository implements IstuMapRepository<Floor> {
  Future<Either<Failure, void>> update(Floor floor);
  Future<Either<Failure, List<Floor>>> getAll(String buildngId);
}

abstract interface class ImageRepository {
  Future<Either<Failure, String>> addImage(String objectId, File image);
  Future<Either<Failure, Image>> getImage(String imageId);
  Future<Either<Failure, List<String>>> getImageByObjectId(String objectId);
}

abstract interface class EdgeRepository implements IstuMapRepository<Edge> {
  Future<Either<Failure, List<Edge>>> getMany({
    String? buildingid,
    String? fromBuildingObjectId,
    String? toBuildingObjectId,
    int? floorNumber,
    String? skip,
    String? take,
  });
}

abstract interface class WaypointRepository
    implements IstuMapRepository<Waypoint> {}
