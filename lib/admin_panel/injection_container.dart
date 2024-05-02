
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:istu_map_admin_panel/admin_panel/core/api_client.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/building_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/edge_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/floor_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/waypoint_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/data/repositories/building_repository_impl.dart';
import 'package:istu_map_admin_panel/admin_panel/data/repositories/edge_repository_impl.dart';
import 'package:istu_map_admin_panel/admin_panel/data/repositories/floor_repository_impl.dart';
import 'package:istu_map_admin_panel/admin_panel/data/repositories/waypoint_repository_impl.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/repositories/repositories.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/building_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/edge_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/floor_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/waypoint_usecases.dart';
import 'package:istu_map_admin_panel/admin_panel/ui/bloc/admin_panel_bloc_bloc.dart';
import 'package:istu_map_admin_panel/core/network_info.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> intiDependencies() async {
  sl.registerFactory(() => AdminPanelBloc(sl(), sl(), sl(), sl()));

  sl.registerLazySingleton(() => BuildingUseCases(sl()));
  sl.registerLazySingleton(() => FloorUsecases(sl()));
  sl.registerLazySingleton(() => EdgeUsecases(sl()));
  sl.registerLazySingleton(() => WaypointUsecases(sl()));

  sl.registerLazySingleton<BuildingRepository>(() => BuildingRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<FloorRepository>(() => FloorRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<EdgeRepository>(() => EdgeRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<WaypointRepository>(() => WaypointRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<BuildingDataSource>(() => BuildingDataSourceImpl(sl()));
  sl.registerLazySingleton<FloorDataSource>(() => FloorDataSourceImpl(sl()));
  sl.registerLazySingleton<EdgeDataSource>(() => EdgeDataSourceImpl(sl()));
  sl.registerLazySingleton<WaypointDataSource>(() => WaypointDataSourceImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}