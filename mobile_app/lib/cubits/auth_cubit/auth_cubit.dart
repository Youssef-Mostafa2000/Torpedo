import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

const String Url = 'http://10.0.2.2:8080';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> userRegister() async {
    try {
      emit(RegisterLoading());
      // register API here
      /******************************************/
      if (isClosed) return;
      emit(RegisterSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(RegisterFailure(errorMessage: 'error'));
    }
  }

  Future<void> userLogin(user) async {
    final dio = Dio();
    emit(LoginLoading());
    try {
      // login API here
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

      SharedPreferences prefs = await SharedPreferences.getInstance();

      User loggedUser = User.fromJson(response.data['myCustomer']);
      await prefs.setBool('isLoggedIn', true);
      await _saveUser(loggedUser, response.data['jwt']);

      if (isClosed) return;
      emit(LoginSuccess(user: loggedUser));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(LoginFailure(
          errorMessage: e.response?.data['message'] ?? 'An error occurred'));
    }
  }

  Future<void> userLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';
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
      await _removeUser();

      if (isClosed) return;
      emit(AuthInitial());
    } on DioException catch (e) {
      // Handle logout error if necessary
    }
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print('checking login');
    if (isLoggedIn) {
      User? user = await loadUser();
      if (user != null) {
        emit(LoginSuccess(user: user));
      } else {
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _saveUser(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
    await prefs.setString('token', token);
  }

  Future<void> _removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
  }

  Future<User?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }
}
