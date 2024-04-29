import 'package:equatable/equatable.dart';

class Edge extends Equatable {
  final String id;
  final String buildingId;
  final int floorNumber;
  final String from;
  final String to;

  const Edge(
      {required this.id,
      required this.buildingId,
      required this.floorNumber,
      required this.from,
      required this.to});

  @override
  List<Object?> get props => [id, buildingId, floorNumber, from, to];
}
