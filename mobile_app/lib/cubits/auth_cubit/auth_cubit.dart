import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
part 'auth_state.dart';

const String Url = 'http://10.0.2.2:8080';

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

  Future<void> userLogin(user) async {
    final dio = new Dio();
    emit(LoginLoading());
    try {
      // login api here
      final response = await dio.post(
        '$Url/authenticate',
        data: user,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
      emit(LoginSuccess());
      //return response;
    } on DioException catch (e) {
      print(e.toString());
      emit(LoginFailure(errorMessage: e.response!.data['message']));
    }
  }
}
