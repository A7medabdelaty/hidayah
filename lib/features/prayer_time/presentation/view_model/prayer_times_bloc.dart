import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerTimesBloc extends Cubit<PrayerTimesStates> {
  PrayerTimesBloc(this.prayerTimesRepo) : super(PrayerTimesInitial());

  final PrayerTimesRepo prayerTimesRepo;

  static PrayerTimesBloc get(context) => BlocProvider.of(context);
}
