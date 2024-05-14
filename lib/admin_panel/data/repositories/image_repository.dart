import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/image_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';
import 'package:istu_map_admin_panel/core/errors/failure.dart';
import 'package:istu_map_admin_panel/core/network_info.dart';
import 'package:istu_map_admin_panel/core/server_error_handler.dart';

class ImageRepositoryImpl extends ExceptionsHandler implements ImageRepository {
  final ImageDataSource dataSource;

  ImageRepositoryImpl(this.dataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, String>> addImage(objectId, image) async {
    return getEither(() => dataSource.addImage(objectId, image));
  }

  @override
  Future<Either<Failure, Image>> getImage(imageId) {
    return getEither(() => dataSource.getImage(imageId));
  }

  @override
  Future<Either<Failure, List<String>>> getImageByObjectId(objectId) {
    return getEither(() => dataSource.getImageByObjectId(objectId));
  }
}
