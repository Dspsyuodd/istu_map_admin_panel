import 'package:istu_map_admin_panel/admin_panel/domain/entities/edge.dart';

abstract interface class EdgeDataSource {
  Future<String> create(Edge object);
  Future<void> delete(String guid);
  Future<Edge> get(String guid);
}

class EdgeDataSourceImpl implements EdgeDataSource {
  @override
  Future<String> create(Edge object) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String guid) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Edge> get(String guid) async {
    // TODO: implement get
    throw UnimplementedError();
  }
}
