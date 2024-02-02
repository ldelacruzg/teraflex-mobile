part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final User? user;
  final StatusUtil status;
  final String? statusMessage;

  const AuthState({
    this.user,
    this.status = StatusUtil.initial,
    this.statusMessage,
  });

  AuthState copyWith({
    User? user,
    StatusUtil? status,
    String? statusMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [status];
}
