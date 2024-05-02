part of 'admin_panel_bloc_bloc.dart';

sealed class AdminPanelEvent extends Equatable {
  const AdminPanelEvent();

  @override
  List<Object> get props => [];
}

class AddBuilding extends AdminPanelEvent {
  final Building building;

  const AddBuilding(this.building);
}

class SelectBuilding extends AdminPanelEvent{
  final int index;

  const SelectBuilding(this.index);
}

class GetBuildings extends AdminPanelEvent {}

class GetFloors extends AdminPanelEvent {}

class GetWaypoints extends AdminPanelEvent {}

class GetEdges extends AdminPanelEvent {}

class AddFloor extends AdminPanelEvent {
  final FloorInfo floorInfo;

  const AddFloor(this.floorInfo);
}

class AddWaypoint extends AdminPanelEvent {}

class AddEdge extends AdminPanelEvent {}

class DeleteBuilding extends AdminPanelEvent {}

class DeleteFloor extends AdminPanelEvent {}

class DeleteWaypoint extends AdminPanelEvent {}

class DeleteEdge extends AdminPanelEvent {}

class UpdateBuilding extends AdminPanelEvent {}

class UpdateFloor extends AdminPanelEvent {}

class UpdateWaypoint extends AdminPanelEvent {}

class UpdateEdge extends AdminPanelEvent {}
