import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidayah/core/constants/endpoint_constants.dart';
import 'package:hidayah/core/errors/exceptions.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/core/network/api_consumer.dart';
import 'package:hidayah/features/qibla/data/repositories/qibla_repo.dart';

import '../models/qibla_model.dart';

class QiblaRepoImpl implements QiblaRepo {
  final ApiConsumer apiConsumer;

  QiblaRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, QiblaModel>> getQiblaDirection() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Left(LocationFailure('Location permission denied'));
        }
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();

      // Make API request
      final response = await apiConsumer.get(
        '${EndpointConstants.qiblaEndpoint}/${position.latitude}/${position.longitude}',
      );
      return Right(QiblaModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    } on LocationServiceDisabledException {
      return Left(LocationFailure('Location services are disabled'));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
