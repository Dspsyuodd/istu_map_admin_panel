import 'package:istu_map_admin_panel/admin_panel/domain/entities/waypoint.dart';

abstract interface class WaypointDataSource {
  Future<String> create(Waypoint object);
  Future<void> delete(String guid);
  Future<Waypoint> get(String guid);
}

class WaypointDataSourceImpl implements WaypointDataSource {
  @override
  Future<String> create(Waypoint object) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String guid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Waypoint> get(String guid) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
