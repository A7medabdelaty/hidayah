import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hidayah/core/network/api_consumer.dart';
import 'package:hidayah/core/network/dio_consumer.dart';
import 'package:hidayah/core/services/location_service.dart';
import 'package:hidayah/core/utils/app_shared_preferences.dart';
import 'package:hidayah/features/prayer_time/data/repos/prayer_times_repo_impl.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AppPreferences>(AppPreferences());
  getIt.registerSingleton<ApiConsumer>(DioConsumer(client: Dio()));
  getIt.registerSingleton<PrayerTimesRepo>(
    PrayerTimesRepoImpl(
      apiConsumer: getIt.get<ApiConsumer>(),
      prefs: getIt.get<AppPreferences>(),
    ),
  );
  getIt.registerSingleton<LocationService>(LocationService());
  getIt.registerFactory(() => PrayerTimesBloc(
        prayerTimesRepo: getIt(),
        locationService: getIt(),
      ));
}
