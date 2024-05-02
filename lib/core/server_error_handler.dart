import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/exceptions.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/core/network_info.dart';

abstract class ExceptionsHandler {
  final NetworkInfo networkInfo;

  ExceptionsHandler(this.networkInfo);

  Future<Either<Failure, T>> getEither<T>(Future<T> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        var result = await request();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          e.message,
          e.code,
        ));
      } catch (e, s) {
        return Left(UnknownFailure(e.toString(), s.toString()));
      }
    }
    return Left(ConnectionFailure("Нет подключения к интернету!"));
  }
}
