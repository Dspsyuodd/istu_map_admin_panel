import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network_info.dart';
import '../../../core/server_error_handler.dart';
import '../datasources/waypoint_data_source.dart';
import '../../domain/entities/waypoint.dart';
import '../../domain/repositories/repositories.dart';

class WaypointRepositoryImpl extends ExceptionsHandler
    implements WaypointRepository {
  final WaypointDataSource dataSource;

  WaypointRepositoryImpl(this.dataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Waypoint object) async {
    return getEither(
      () => dataSource.create(
        {
          "BuildingId": object.buildingId,
          "Floor": object.floor,
          "Type": object.type.index,
          "Title": object.title,
          "X": object.x,
          "Y": object.y,
          if (object.keywords != null) "Keywords": object.keywords,
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> delete(waypoint) async {
    return getEither(() => dataSource.delete(waypoint.id));
  }

  @override
  Future<Either<Failure, Waypoint>> get(String guid) async {
    return getEither(
        () => dataSource.get(guid).then((value) => value as Waypoint));
  }
}
