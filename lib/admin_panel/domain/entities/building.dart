import 'package:equatable/equatable.dart';

import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';

class Building extends Equatable {
  final String id;
  final String title;
  final int floorNumbers;
  final List<Floor> floors;
  final String? description;

  const Building({
    required this.id,
    required this.title,
    required this.floorNumbers,
    required this.floors,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, floorNumbers, floors, description];
}
