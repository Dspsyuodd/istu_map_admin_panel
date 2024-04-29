import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/core/network_info.dart';
import 'package:istu_map_admin_panel/admin_panel/core/server_error_handler.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/floor_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class FloorRepositoryImpl extends ServerExceptionsHandler implements FloorRepository {
  final FloorDataSource dataSource;

  FloorRepositoryImpl(this.dataSource, NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Floor object) async {
    return getEither(() => dataSource.create(object));
  }

  @override
  Future<Either<Failure, void>> delete(String guid) async {
    return getEither(() => dataSource.delete(guid));
  }

  @override
  Future<Either<Failure, Floor>> get(String guid) async {
    return getEither(() => dataSource.get(guid));
  }

  @override
  Future<Either<Failure, String>> update(Floor floor) async {
    return getEither(() => dataSource.update(floor));
  }
}
