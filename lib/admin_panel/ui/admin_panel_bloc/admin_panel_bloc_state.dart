part of 'admin_panel_bloc_bloc.dart';

sealed class AdminPanelState extends Equatable {
  const AdminPanelState();

  @override
  List<Object> get props => [];
}

final class Empty extends AdminPanelState {}

final class Loading extends AdminPanelState {}

final class Loaded extends AdminPanelState {
  final List<Building> buildings;
  final List<Floor> floors;
  final int? selectedBuildingIndex;

  const Loaded({
    required this.buildings,
    required this.floors,
    this.selectedBuildingIndex,
  });
}

final class UnknownError extends AdminPanelState {
  final String message;
  final String stackTrace;

  const UnknownError({
    required this.message,
    required this.stackTrace,
  });
}

final class ServerError extends AdminPanelState {
  final String message;
  final String code;

  const ServerError({required this.message, required this.code});
}
