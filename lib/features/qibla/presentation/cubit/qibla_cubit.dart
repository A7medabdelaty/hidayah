import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/features/qibla/data/models/qibla_model.dart';
import 'package:hidayah/features/qibla/data/repositories/qibla_repo_impl.dart';

part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  final QiblaRepoImpl qiblaRepository;

  QiblaCubit({required this.qiblaRepository}) : super(QiblaInitialState());

  Future<void> getQiblaDirection() async {
    emit(QiblaLoadingState());
    final qiblaData = await qiblaRepository.getQiblaDirection();
    qiblaData.fold(
      (failure) => emit(QiblaErrorState(failure.errMessage)),
      (success) => emit(QiblaSuccessState(success)),
    );
  }
}
