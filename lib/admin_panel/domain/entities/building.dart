import 'package:equatable/equatable.dart';


class Building extends Equatable {
  final String id;
  final String title;
  final List<FloorInfo> floors;
  final String? description;
  final String address;
  final double latitude;
  final double longitude;
  final String? keywords;
  
  

  const Building({
    required this.id,
    required this.title,
    required this.floors,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.keywords,
  });

  @override
  List<Object?> get props => [id, title, floors, description];
}

class FloorInfo extends Equatable {
  final int floorNumber;
  final String floorId;

  const FloorInfo({required this.floorNumber, required this.floorId});
  
  @override
  List<Object?> get props => [floorNumber, floorId];
}