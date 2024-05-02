import 'package:equatable/equatable.dart';


class Building extends Equatable {
  final String id;
  final String title;
  final List<FloorInfo> floors;
  final String? description;
  final String address;
  final double latitude;
  final double longitude;
  
  

  const Building({
    required this.id,
    required this.title,
    required this.floors,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, title, floors, description];
}

class FloorInfo extends Equatable {
  final int floorNumber;
  final String imageLink;

  const FloorInfo({required this.floorNumber, required this.imageLink});
  
  @override
  List<Object?> get props => [floorNumber, imageLink];
}