import '../../../core/errors/failure.dart';

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super('Invalid email or password');
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure() : super('Email already in use');
}

class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure() : super('Current password is incorrect');
}