import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerTimesBloc extends Cubit<PrayerTimesStates> {
  PrayerTimesBloc(this.prayerTimesRepo) : super(PrayerTimesInitial());

  final PrayerTimesRepo prayerTimesRepo;

  static PrayerTimesBloc get(context) => BlocProvider.of(context);

  Future<void> fetchPrayerTimes(
      {required String city, required String country}) async {
    emit(PrayerTimesLoading());
    prayerTimesRepo
        .fetchPrayerTimes(city: city, country: country)
        .then((value) {
      value.fold((l) => emit(PrayerTimesError(l.errMessage)),
          (r) => emit(PrayerTimesSuccess(r)));
    });
  }
}
