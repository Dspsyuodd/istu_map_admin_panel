import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network_info.dart';
import '../../../core/server_error_handler.dart';
import '../datasources/edge_data_source.dart';
import '../../domain/entities/edge.dart';
import '../../domain/repositories/repositories.dart';

class EdgeRepositoryImpl extends ExceptionsHandler implements EdgeRepository {
  final EdgeDataSource dataSource;

  EdgeRepositoryImpl(this.dataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Edge object) async {
    return await getEither(
      () => dataSource.create(
        {
          "Edges": [
            {
              "FromId": object.fromId,
              "ToId": object.toId,
            }
          ]
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> delete(edge) async {
    return await getEither(() => dataSource.delete(edge.id));
  }

  @override
  Future<Either<Failure, Edge>> get(String guid) async {
    return await getEither(() => dataSource.get(guid).then((value) => value as Edge));
  }

  @override
  Future<Either<Failure, List<Edge>>> getMany({
    String? buildingid,
    String? fromBuildingObjectId,
    String? toBuildingObjectId,
    int? floorNumber,
    String? skip,
    String? take,
  }) async {
    return await getEither(() => dataSource
        .getMany(
          buildingid: buildingid,
          fromBuildingObjectId: fromBuildingObjectId,
          toBuildingObjectId: toBuildingObjectId,
          floorNumber: floorNumber,
          skip: skip,
          take: take,
        )
        .then(
            (value) => value.map((e) => e as Edge).toList()));
  }
}
