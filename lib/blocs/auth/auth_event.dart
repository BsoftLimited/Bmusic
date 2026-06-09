// auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmail extends AuthEvent {
    final String email;
    final String password;
    final String firstName;
    final String lastName;
    final String username;

    const SignUpWithEmail({
        required this.email, required this.password, required this.firstName, required this.lastName,
        required this.username,});

    @override
    List<Object> get props => [email, password, firstName, lastName, username];
}

class LoginWithEmail extends AuthEvent {
    final String email;
    final String password;

    const LoginWithEmail({required this.email, required this.password });

    @override
    List<Object> get props => [email, password ];
}

class SignOut extends AuthEvent {}

class GetCurrentUser extends AuthEvent {}