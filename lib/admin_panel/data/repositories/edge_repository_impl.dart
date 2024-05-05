import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/core/network_info.dart';
import 'package:istu_map_admin_panel/core/server_error_handler.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/edge_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

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
  Future<Either<Failure, void>> delete(String guid) async {
    return await getEither(() => dataSource.delete(guid));
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
