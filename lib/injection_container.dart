import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_instance.dart';
import 'core/network/network_info.dart';
import 'ui/news_feature/data/datasources/news_local_data_source.dart';
import 'ui/news_feature/data/datasources/news_remote_data_source.dart';
import 'ui/news_feature/repository/news_repository.dart';
import 'ui/news_feature/view_model/favorite_news_view_model.dart';
import 'ui/news_feature/view_model/news_view_model.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //** view model
  sl.registerLazySingleton(
    () => NewsViewModel(
      newsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => FavoriteNewsViewModel(
      newsRepository: sl(),
    ),
  );

  //** Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      allArticalRemoteDataSource: sl(),
      newsLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //** Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(dio: sl<DioInstance>().dioInstance),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(
        sharedPreferences: sl(), defaultCacheManager: sl()),
  );

  //** External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DefaultCacheManager());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<DioInstance>(() => DioInstanceImpl());
}
