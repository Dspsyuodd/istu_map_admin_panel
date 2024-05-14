import 'dart:html';

import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../entities/floor.dart';
import '../repositories/repositories.dart';

class FloorUsecases {
  final FloorRepository repository;
  final ImageRepository imageRepository;

  FloorUsecases(this.repository, this.imageRepository);

  Future<(Either<Failure, String>, Either<Failure, String>?)> create(
      Floor object, File? image) async {
    var result = await repository.create(object);
    Either<Failure, String>? imageRes;
    await result.fold(
      (l) async => null,
      (r) async {
        if (image != null) {
          imageRes = await imageRepository.addImage(r, image);
        }
      },
    );
    return (result, imageRes);
  }

  Future<Either<Failure, void>> delete(Floor floor) async {
    return await repository.delete(floor);
  }

  Future<Either<Failure, Floor>> get(String guid) async {
    return await repository.get(guid);
  }

  Future<Either<Failure, List<Floor>>> getAll(String buildingId) async {
    return await repository.getAll(buildingId);
  }
}
