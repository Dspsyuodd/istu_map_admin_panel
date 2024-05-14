import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../entities/waypoint.dart';
import '../repositories/repositories.dart';

class WaypointUsecases {
  final WaypointRepository repository;

  WaypointUsecases(this.repository);

  Future<Either<Failure, String>> create(Waypoint object) async {
    return await repository.create(object);
  }

  Future<Either<Failure, void>> delete(Waypoint waypoint) async {
    return await repository.delete(waypoint);
  }

  Future<Either<Failure, Waypoint>> get(String guid) async {
    return await repository.get(guid);
  }
}
