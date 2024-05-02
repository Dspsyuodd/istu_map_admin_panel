import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/admin_panel/data/models/waypoint_model.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/core/network_info.dart';
import 'package:istu_map_admin_panel/core/server_error_handler.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/waypoint_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class WaypointRepositoryImpl extends ExceptionsHandler
    implements WaypointRepository {
  final WaypointDataSource dataSource;

  WaypointRepositoryImpl(this.dataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Waypoint object) async {
    return getEither(() => dataSource.create(object as WaypointModel));
  }

  @override
  Future<Either<Failure, void>> delete(String guid) async {
    return getEither(() => dataSource.delete(guid));
  }

  @override
  Future<Either<Failure, Waypoint>> get(String guid) async {
    return getEither(() => dataSource.get(guid));
  }
}
