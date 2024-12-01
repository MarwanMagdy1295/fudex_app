import 'package:get_it/get_it.dart';
import 'package:kaf_app/src/core/api/network_service.dart';
import 'package:kaf_app/src/core/services/hive_service.dart';
import 'package:kaf_app/src/core/services/prefs_service.dart';
import 'package:kaf_app/src/modules/add_new_product_screen/presentation/controller/cubit/add_product_cubit.dart';
import 'package:kaf_app/src/modules/products_screen/presentation/controller/cubit/products_cubit.dart';

final di = GetIt.instance;

class DiService {
  static init() async {
    // router
    // di.registerLazySingleton(() => AppRouter());

    // PrefsService
    di.registerLazySingleton(() => PrefsService());
    await di<PrefsService>().init();

    // HiveService
    di.registerLazySingleton(() => HiveService());
    await di<HiveService>().init();

    // NetworkService
    di.registerLazySingleton(
      () => NetworkService(
        prefsService: di(),
      ),
    );

    // ProductsScreen
    // di.registerLazySingleton(
    //   () => AppVersionRemoteDataSource(
    //     networkService: di(),
    //   ),
    // );
    // di.registerLazySingleton(
    //   () => AppVersionRepository(
    //     appVersionRemoteDataSource: di(),
    //   ),
    // );
    di.registerLazySingleton(
      () => ProductsCubit(),
    );

    // AddProductsScreen
    // di.registerLazySingleton(
    //   () => SelectCountryRemoteDataSource(
    //     networkService: di(),
    //   ),
    // );
    // di.registerLazySingleton(
    //   () => SelectCountryRepository(
    //     selectCountryRepository: di(),
    //   ),
    // );
    di.registerLazySingleton(
      () => AddProductCubit(),
    );
    // // LandingScreen
    // di.registerLazySingleton(
    //   () => LandingScreenRemoteDataSource(
    //     networkService: di(),
    //   ),
    // );
    // di.registerLazySingleton(
    //   () => LandingScreenRepository(
    //     landingRepository: di(),
    //   ),
    // );
    // di.registerLazySingleton(
    //   () => LandingScreenCubit(
    //     landingRepository: di(),
    //   ),
    // );
  }
}
