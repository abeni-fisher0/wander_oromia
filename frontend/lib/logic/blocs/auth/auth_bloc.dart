// logic/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) {
      emit(AuthLoading());
      // Simulate login logic...
      Future.delayed(const Duration(seconds: 1), () {
        emit(AuthSuccess());
      });
    });

    on<AuthLogout>((event, emit) => emit(AuthInitial()));
  }
}
