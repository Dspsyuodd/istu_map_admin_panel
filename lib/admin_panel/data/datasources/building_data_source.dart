import 'package:istu_map_admin_panel/admin_panel/domain/entities/building.dart';

abstract interface class BuildingDataSource {
  Future<String> create(Building object);
  Future<void> delete(String guid);
  Future<Building> get(String guid);
  Future<void> update(Building object);
}

class BuildingDataSourceImpl implements BuildingDataSource {
  @override
  Future<String> create(Building object) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String guid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Building> get(String guid) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> update(Building object) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
