import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bmusic/repositories/models/user.dart';
import 'package:bmusic/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
    final UserRepository __userRepository = UserRepository();

    AuthBloc() : super(AuthInitial()) {
        on<SignUpWithEmail>(_signUpWithEmail);
        on<SignOut>(_signOut);
        on<GetCurrentUser>(_getCurrentUser);
        on<LoginWithEmail>(_loginWithEmail);
    }

    Future<void> _signUpWithEmail(SignUpWithEmail event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
            final user = await __userRepository.signUpWithEmail(
                firstName: event.firstName, lastName: event.lastName, email: event.email,
                username: event.username, password: event.password);

            emit(Authenticated(user));
        } catch (e) {
            emit(AuthError(e.toString()));
        }
    }

    Future<void> _loginWithEmail(LoginWithEmail event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
            final user = await __userRepository.loginWithEmail(email: event.email, password: event.password);

            emit(Authenticated(user));
        } catch (e) {
            emit(AuthError(e.toString()));
        }
    }

    Future<void> _signOut( SignOut event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
            await __userRepository.logout();
            emit(Unauthenticated());
        } catch (e) {
            emit(AuthError(e.toString()));
        }
    }

    Future<void> _getCurrentUser(GetCurrentUser event, Emitter<AuthState> emit) async {
        emit(AuthLoading());
        try {
            final user = await __userRepository.fetchUser();

            emit(Authenticated(user));
        } catch (e) {
            emit(AuthError(e.toString()));
        }
    }
}