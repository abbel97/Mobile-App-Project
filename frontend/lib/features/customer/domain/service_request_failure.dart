import '../../../core/errors/failure.dart';

class RequestNotFoundFailure extends ServerFailure {
  const RequestNotFoundFailure() : super('Request not found');
}

class RequestAlreadyAcceptedFailure extends ServerFailure {
  const RequestAlreadyAcceptedFailure() : super('Request is no longer available');
}