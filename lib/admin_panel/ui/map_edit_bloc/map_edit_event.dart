part of 'map_edit_bloc.dart';

sealed class MapEditEvent extends Equatable {
  const MapEditEvent();

  @override
  List<Object> get props => [];
}

class GetWaypoints extends MapEditEvent {}

class GetEdges extends MapEditEvent {}

class AddWaypoint extends MapEditEvent {
  final Waypoint waypoint;

  const AddWaypoint(this.waypoint);
}

class InitFloors extends MapEditEvent {
  final List<Floor> floors;

  const InitFloors(this.floors);
}

class ChangeEditMode extends MapEditEvent {
  final MapEditMode editMode;

  const ChangeEditMode(this.editMode);
}

class AddEdge extends MapEditEvent {
  final String fromId;
  final String toId;
  final int floorNumber;

  const AddEdge(this.fromId, this.toId, this.floorNumber);
}


class DeleteWaypoint extends MapEditEvent {
  final Waypoint waypoint;
  const DeleteWaypoint(this.waypoint);
}

class AddEdgeBetweenFloor extends MapEditEvent {
  final Waypoint waypoint;
  const AddEdgeBetweenFloor(this.waypoint);
}

class DeleteEdge extends MapEditEvent {}

class UpdateWaypoint extends MapEditEvent {}

class UpdateEdge extends MapEditEvent {}
