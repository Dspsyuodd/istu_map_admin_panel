import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/building.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class BuildingUseCases {
  final BuildingRepository repository;

  BuildingUseCases(this.repository);

  Future<Either<Failure, String>> create(Building object) async {
    return await repository.create(object);
  }

  Future<Either<Failure, void>> delete(String guid) async {
    return await repository.delete(guid);
  }

  Future<Either<Failure, Building>> get(String guid) async {
    return await repository.get(guid);
  }
  Future<Either<Failure, List<Building>>> getAll() async {
    return await repository.getAll();
  }

  Future<Either<Failure, void>> update(Building object) async {
    return await repository.update(object);
  }
}
