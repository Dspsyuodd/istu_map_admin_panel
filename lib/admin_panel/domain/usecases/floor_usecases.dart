import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class FloorUsecases {
  final FloorRepository repository;

  FloorUsecases(this.repository);

  Future<Either<Failure, String>> create(Floor object) async {
    return await repository.create(object);
  }

  Future<Either<Failure, void>> delete(String guid) async {
    return await repository.delete(guid);
  }

  Future<Either<Failure, Floor>> get(String guid) async {
    return await repository.get(guid);
  }
  Future<Either<Failure, List<Floor>>> getAll(String buildingId) async {
    return await repository.getAll(buildingId);
  }
}
