import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/building.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/istu_map_repository.dart';

abstract interface class BuildingRepository
    implements IstuMapRepository<Building> {
  Future<Either<Failure, void>> update(Building object);
  Future<Either<Failure, List<Building>>> getAll();
}

abstract interface class FloorRepository implements IstuMapRepository<Floor> {
  Future<Either<Failure, void>> update(Floor floor);
  Future<Either<Failure, List<Floor>>> getAll(String buildngId);
}

abstract interface class EdgeRepository implements IstuMapRepository<Edge> {}

abstract interface class WaypointRepository
    implements IstuMapRepository<Waypoint> {}
