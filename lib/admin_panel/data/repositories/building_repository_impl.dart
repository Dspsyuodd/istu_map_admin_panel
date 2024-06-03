import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network_info.dart';
import '../../../core/server_error_handler.dart';
import '../datasources/building_data_source.dart';
import '../../domain/entities/building.dart';
import '../../domain/repositories/repositories.dart';

class BuildingRepositoryImpl extends ExceptionsHandler
    implements BuildingRepository {
  final BuildingDataSource dataSource;

  BuildingRepositoryImpl(this.dataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Building object) async {
    return await getEither(
      () => dataSource.create(
        {
          "Title": object.title,
          "Address": object.address,
          if (object.description != null) "Description": object.description!,
          "ExternalPosition": {
            "Latitude": object.latitude.toString(),
            "Longitude": object.longitude.toString(),
          },
          if (object.keywords != null) "Keywords": object.keywords,
        },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> delete(building) async {
    return await getEither(() => dataSource.delete(building.id));
  }

  @override
  Future<Either<Failure, Building>> get(String guid) async {
    return await getEither(() => dataSource.get(guid));
  }

  @override
  Future<Either<Failure, void>> update(Building object) async {
    return await getEither(() => dataSource.update(
          {
            "Id": object.id,
            "Title": object.title,
            "Address": object.address,
            if (object.description != null) "Description": object.description!,
            "Latitude": object.latitude.toString(),
            "Longitude": object.longitude.toString(),
          },
        ));
  }

  @override
  Future<Either<Failure, List<Building>>> getAll() async {
    return await getEither(
      () => dataSource.getAll().then(
            (value) => value.map((e) => e as Building).toList(),
          ),
    );
  }
}
