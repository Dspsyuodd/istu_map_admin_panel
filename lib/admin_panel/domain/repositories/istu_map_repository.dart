import 'package:dartz/dartz.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';

abstract interface class IstuMapRepository<Type> {
  Future<Either<Failure, Type>> get(String guid);
  Future<Either<Failure, String>> create(Type object);
  Future<Either<Failure, void>> delete(String guid);
}