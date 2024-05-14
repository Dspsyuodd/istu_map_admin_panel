import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';

class ImageUsecases {
  final ImageRepository repository;
  const ImageUsecases(this.repository);

  Future<Either<Failure, Image>> getImage(String imageId) async {
    return await repository.getImage(imageId);
  }

  Future<Either<Failure, List<Image>>> getImageByObjectId(
      String objectId) async {
    var imageGuids = await repository.getImageByObjectId(objectId);

    return await imageGuids.fold(
      (l) async => Left(l),
      (r) async {
        var images = <Image>[];
        for (var guid in r) {
          var image = await repository.getImage(guid);
          image.fold((l) => null, (r) => images.add(r));
        }
        return Right(images);
      },
    );
  }
}
