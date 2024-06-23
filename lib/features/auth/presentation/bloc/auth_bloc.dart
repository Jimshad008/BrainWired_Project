import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;


  AuthBloc({required UserLogin userLogin}) : _userLogin=userLogin,super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
final res=await _userLogin.authRepository.loginWithEmailAndPassword(email:event.email,password:event.password,context: event.context);
res.fold(
      (l) => emit(AuthFailure( l.message)),
      (uid) => emit(AuthSuccess( uid)),
);
    });

  }
}
