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

class SelectBuilding extends AdminPanelEvent {
  final int index;

  const SelectBuilding(this.index);
}

class GetBuildings extends AdminPanelEvent {}

class GetFloors extends AdminPanelEvent {}

class AddFloor extends AdminPanelEvent {
  final FloorInfo floorInfo;
  final File? image;

  const AddFloor(this.floorInfo, this.image);
}

class DeleteBuilding extends AdminPanelEvent {}

class DeleteFloor extends AdminPanelEvent {
  final Floor floor;

  const DeleteFloor(this.floor);
}

class UpdateBuilding extends AdminPanelEvent {}

class UpdateFloor extends AdminPanelEvent {}
