import 'package:istu_map_admin_panel/admin_panel/data/models/floor_model.dart';

import '../../domain/entities/building.dart';

import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@JsonSerializable()
class BuildingModel extends Building {
  const BuildingModel({required super.id, required super.title, required super.floorNumbers, required super.floors, required super.description});

  factory BuildingModel.fromJson(Map<String, dynamic> json) => _$BuildingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);
}