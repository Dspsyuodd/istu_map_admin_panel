import 'package:istu_map_admin_panel/admin_panel/domain/entities/floor.dart';

abstract interface class FloorDataSource {
  Future<String> create(Floor object);
  Future<void> delete(String guid);
  Future<Floor> get(String guid);
  Future<String> update(Floor object);
}

class FloorDataSourceImpl implements FloorDataSource {
  @override
  Future<String> create(Floor object) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String guid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Floor> get(String guid) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<String> update(Floor object) {
    // TODO: implement update
    throw UnimplementedError();
  }
}