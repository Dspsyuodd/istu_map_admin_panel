import '../../domain/entities/building.dart';

import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@JsonSerializable()
class BuildingModel extends Building {
  const BuildingModel({
    required super.id,
    required super.title,
    required super.floors,
    required super.description,
    required super.address,
    required super.latitude,
    required super.longitude,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);
}

@JsonSerializable()
class FloorInfoModel extends FloorInfo {
  const FloorInfoModel({required super.floorNumber, required super.imageLink});
  factory FloorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FloorInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$FloorInfoModelToJson(this);
}
