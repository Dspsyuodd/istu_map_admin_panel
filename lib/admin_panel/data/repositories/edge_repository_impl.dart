import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/admin_panel/data/models/edge_model.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/core/network_info.dart';
import 'package:istu_map_admin_panel/core/server_error_handler.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/edge_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';

class EdgeRepositoryImpl extends ExceptionsHandler implements EdgeRepository {
  final EdgeDataSource dataSource;

  EdgeRepositoryImpl(this.dataSource, NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, String>> create(Edge object) async {
    return getEither(() => dataSource.create(object as EdgeModel));
  }

  @override
  Future<Either<Failure, void>> delete(String guid) async {
    return getEither(() => dataSource.delete(guid));
  }

  @override
  Future<Either<Failure, Edge>> get(String guid) async {
    return getEither(() => dataSource.get(guid));
  }
}
