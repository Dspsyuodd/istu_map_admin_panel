import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/admin_panel/core/errors/exceptions.dart';
import 'package:istu_map_admin_panel/admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/admin_panel/core/network_info.dart';

abstract class ServerExceptionsHandler {
  final NetworkInfo networkInfo;

  ServerExceptionsHandler(this.networkInfo);

  Future<Either<Failure, T>> getEither<T>(
      Future<T> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await request();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure("Нет подключения к интернету!"));
  }
}
