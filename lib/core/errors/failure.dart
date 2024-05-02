import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;
  final int code;

  ServerFailure(this.message, this.code);
  @override
  List<Object> get props => [message, code];
}

class ConnectionFailure extends Failure {
  final String message;

  ConnectionFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class ClientFailure extends Failure {
  final String message;

  ClientFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  final String message;
  final String stackTrace;

  UnknownFailure(this.message, this.stackTrace);

  @override
  List<Object?> get props => [message, stackTrace];
}
