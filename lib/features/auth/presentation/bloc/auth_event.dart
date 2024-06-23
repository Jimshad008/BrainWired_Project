part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  AuthLogin({
    required this.email,
    required this.password,
    required this.context,
  });
}
