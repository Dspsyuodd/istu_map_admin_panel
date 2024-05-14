
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:istu_map_admin_panel/admin_panel/data/datasources/image_data_source.dart';
import 'package:istu_map_admin_panel/admin_panel/data/repositories/image_repository.dart';
import 'package:istu_map_admin_panel/admin_panel/domain/usecases/image_usecases.dart';
import 'core/api_client.dart';
import 'data/datasources/building_data_source.dart';
import 'data/datasources/edge_data_source.dart';
import 'data/datasources/floor_data_source.dart';
import 'data/datasources/waypoint_data_source.dart';
import 'data/repositories/building_repository_impl.dart';
import 'data/repositories/edge_repository_impl.dart';
import 'data/repositories/floor_repository_impl.dart';
import 'data/repositories/waypoint_repository_impl.dart';
import 'domain/repositories/repositories.dart';
import 'domain/usecases/building_usecases.dart';
import 'domain/usecases/edge_usecases.dart';
import 'domain/usecases/floor_usecases.dart';
import 'domain/usecases/waypoint_usecases.dart';
import 'ui/admin_panel_bloc/admin_panel_bloc_bloc.dart';
import 'ui/map_edit_bloc/map_edit_bloc.dart';
import '../core/network_info.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> intiDependencies() async {
  sl.registerFactory(() => AdminPanelBloc(sl(), sl(), sl()));
  sl.registerFactory(() => MapEditBloc(sl(), sl()));

  sl.registerLazySingleton(() => BuildingUseCases(sl()));
  sl.registerLazySingleton(() => FloorUsecases(sl(), sl()));
  sl.registerLazySingleton(() => EdgeUsecases(sl()));
  sl.registerLazySingleton(() => WaypointUsecases(sl()));
  sl.registerLazySingleton(() => ImageUsecases(sl()));

  sl.registerLazySingleton<BuildingRepository>(() => BuildingRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<FloorRepository>(() => FloorRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<EdgeRepository>(() => EdgeRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<WaypointRepository>(() => WaypointRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<BuildingDataSource>(() => BuildingDataSourceImpl(sl()));
  sl.registerLazySingleton<FloorDataSource>(() => FloorDataSourceImpl(sl()));
  sl.registerLazySingleton<EdgeDataSource>(() => EdgeDataSourceImpl(sl()));
  sl.registerLazySingleton<WaypointDataSource>(() => WaypointDataSourceImpl(sl()));
  sl.registerLazySingleton<ImageDataSource>(() => ImageDataSourceImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}