import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class EdgeUsecases {
  final EdgeRepository repository;

  EdgeUsecases(this.repository);

  Future<Either<Failure, String>> create(Edge object) async {
    return await repository.create(object);
  }

  Future<Either<Failure, void>> delete(String guid) async {
    return await repository.delete(guid);
  }

  Future<Either<Failure, Edge>> get(String guid) async {
    return await repository.get(guid);
  }

  Future<Either<Failure, List<Edge>>> getMany({
    String? buildingid,
    String? fromBuildingObjectId,
    String? toBuildingObjectId,
    int? floorNumber,
    String? skip,
    String? take,
  }) async {
    return await repository.getMany(
      buildingid: buildingid,
      fromBuildingObjectId: fromBuildingObjectId,
      toBuildingObjectId: toBuildingObjectId,
      floorNumber: floorNumber,
      skip: skip,
      take: take,
    );
  }
}
