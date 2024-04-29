import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {
  final String message;

  ConnectionFailure(this.message);
  @override
  List<Object?> get props => [message];
}
