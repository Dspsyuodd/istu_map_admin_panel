import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../entities/building.dart';
import '../repositories/repositories.dart';

class BuildingUseCases {
  final BuildingRepository repository;

  BuildingUseCases(this.repository);

  Future<Either<Failure, String>> create(Building object) async {
    return await repository.create(object);
  }

  Future<Either<Failure, void>> delete(Building building) async {
    return await repository.delete(building);
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
