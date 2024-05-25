import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> userRegister() async {
    try {
      emit(RegisterLoading());
      // register api here
      /******************************************/
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'error'));
    }
  }

  Future<void> userLogin() async {
    try {
      emit(LoginLoading());
      // login api here
      /******************************************/
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errorMessage: 'error'));
    }
  }
}
