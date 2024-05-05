part of 'map_edit_bloc.dart';

sealed class MapEditState extends Equatable {
  const MapEditState();

  @override
  List<Object> get props => [];
}

final class MapEditInitial extends MapEditState {}

final class MapEmpty extends MapEditState {}

final class MapLoading extends MapEditState {}

final class MapLoaded extends MapEditState {
  final List<(List<Waypoint> waypoints, List<(Offset from, Offset to)> edges)>
      floors;

  final MapEditMode editMode;
  const MapLoaded(this.floors, this.editMode);
}

final class MapUnknownError extends MapEditState {
  final String message;
  final String stackTrace;

  const MapUnknownError({
    required this.message,
    required this.stackTrace,
  });
}

final class MapServerError extends MapEditState {
  final String message;
  final String code;

  const MapServerError({required this.message, required this.code});
}
