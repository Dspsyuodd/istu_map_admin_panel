import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/building.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/istu_map_repository.dart';

abstract interface class BuildingRepository
    implements IstuMapRepository<Building> {
  Future<Either<Failure, void>> update(Building object);
}

abstract interface class FloorRepository implements IstuMapRepository<Floor> {
  Future<Either<Failure, String>> update(Floor floor);
}

abstract interface class EdgeRepository implements IstuMapRepository<Edge> {}

abstract interface class WaypointRepository
    implements IstuMapRepository<Waypoint> {}
