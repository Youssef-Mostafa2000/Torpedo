import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

      // Save user login status and token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', response.data['jwt']);

      emit(LoginSuccess());
      //return response;
    } on DioException catch (e) {
      print(e.toString());
      emit(LoginFailure(errorMessage: e.response!.data['message']));
    }
  }

  Future<void> userLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final dio = new Dio();
    dio.options.headers["Authorization"] = 'Bearer ${token}';
    try {
      final response = await dio.post(
        '$Url/signout',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('token');
      emit(AuthInitial());

      print(response);
    } on DioException catch (e) {}
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      emit(LoginSuccess());
    } else {
      emit(AuthInitial());
    }
  }
}
