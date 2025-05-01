import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/core/models/location_data.dart';
import 'package:hidayah/core/network/api_consumer.dart';
import 'package:hidayah/core/services/service_locator.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/location_picker_map.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';
import 'package:hidayah/features/qibla/data/repositories/qibla_repo_impl.dart';
import 'package:hidayah/features/qibla/presentation/cubit/qibla_cubit.dart';
import 'package:hidayah/features/qibla/presentation/view/qibla_view.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> push<T>(Widget page) {
    return navigatorKey.currentState!.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<void> pushQiblaView() {
    return push(
      BlocProvider(
        create: (context) => QiblaCubit(
            qiblaRepository:
                QiblaRepoImpl(apiConsumer: getIt.get<ApiConsumer>())),
        child: const QiblaView(),
      ),
    );
  }

  static Future<void> pushLocationPicker(
      PrayerTimesBloc bloc, Function(LocationData) onLocationPicked) {
    return push(
      BlocProvider.value(
        value: bloc,
        child: LocationPickerMap(
          onLocationPicked: onLocationPicked,
        ),
      ),
    );
  }

  static void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }
}
