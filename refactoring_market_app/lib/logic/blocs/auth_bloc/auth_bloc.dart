import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../logic/providers/user_provider.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserProvider userProvider;

  AuthBloc(this.userProvider) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthUsingEmailAndPassword) {
        emit(AuthLoading());
        await userProvider.authenticate(mail: event.email, password: event.pass)
            ? emit(Authenticated())
            : emit(Unauthenticated());
      } else if (event is RegisterUsingEmailAndPassword) {
        emit(AuthLoading());
        await userProvider.register(mail: event.email, password: event.pass)
            ? emit(Authenticated())
            : emit(Unauthenticated());
      }
    });
  }
}
