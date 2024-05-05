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



class AddFloor extends AdminPanelEvent {
  final FloorInfo floorInfo;

  const AddFloor(this.floorInfo);
}


class DeleteBuilding extends AdminPanelEvent {}

class DeleteFloor extends AdminPanelEvent {}



class UpdateBuilding extends AdminPanelEvent {}

class UpdateFloor extends AdminPanelEvent {}


