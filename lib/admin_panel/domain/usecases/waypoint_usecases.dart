import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class WaypointUsecases {
  final WaypointRepository repository;

  WaypointUsecases(this.repository);

  Future<Either<Failure, String>> create(Waypoint object) async {
    return await repository.create(object);
  }

  Future<Either<Failure, void>> delete(String guid) async {
    return await repository.delete(guid);
  }

  Future<Either<Failure, Waypoint>> get(String guid) async {
    return await repository.get(guid);
  }
}
