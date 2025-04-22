part of 'qibla_cubit.dart';

abstract class QiblaState {}

class QiblaInitialState extends QiblaState {}

class QiblaLoadingState extends QiblaState {}

class QiblaSuccessState extends QiblaState {
  final QiblaModel data;

  QiblaSuccessState(this.data);
}

class QiblaErrorState extends QiblaState {
  final String errMessage;

  QiblaErrorState(this.errMessage);
}
