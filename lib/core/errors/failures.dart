abstract class Failure {
  final String errMessage;
  final int? statusCode;

  Failure(this.errMessage, [this.statusCode]);
}

class ServerFailure extends Failure {
  ServerFailure([super.errMessage = 'Server Error', super.statusCode = 500]);
}

class CacheFailure extends Failure {
  CacheFailure([super.errMessage = 'Cache Error', super.statusCode = 500]);
}
// Add more failures as needed
