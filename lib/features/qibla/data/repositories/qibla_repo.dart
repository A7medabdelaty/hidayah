import 'package:dartz/dartz.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/features/qibla/data/models/qibla_model.dart';

abstract class QiblaRepo {
  Future<Either<Failure, QiblaModel>> getQiblaDirection();
}
