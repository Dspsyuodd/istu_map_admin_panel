import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network_info.dart';
import '../../../core/server_error_handler.dart';
import '../datasources/floor_data_source.dart';
import '../../domain/entities/floor.dart';
import '../../domain/repositories/repositories.dart';

class FloorRepositoryImpl extends ExceptionsHandler implements FloorRepository {
  final FloorDataSource dataSource;

  FloorRepositoryImpl(this.dataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Floor object) async {
    return getEither(
      () => dataSource.create(
        object.buildingId,
        {
          "FloorNumber": object.floorNumber,
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> delete(floor) async {
    return getEither(
        () => dataSource.delete(floor.buildingId, floor.floorNumber));
  }

  @override
  Future<Either<Failure, Floor>> get(String guid) async {
    return getEither(
        () => dataSource.get(guid).then((value) => value as Floor));
  }

  @override
  Future<Either<Failure, List<Floor>>> getAll(String buildingId) async {
    return getEither(() => dataSource
        .getAll(buildingId)
        .then((value) => value.map((e) => e as Floor).toList()));
  }

  @override
  Future<Either<Failure, void>> update(Floor floor) async {
    return getEither(() => dataSource.update(floor.buildingId, {}));
  }
}
