import 'package:equatable/equatable.dart';

class Edge extends Equatable {
  final String id;
  final String fromId;
  final String toId;

  const Edge(
      {required this.id,
      required this.fromId,
      required this.toId});

  @override
  List<Object?> get props => [id, fromId, toId];
}
