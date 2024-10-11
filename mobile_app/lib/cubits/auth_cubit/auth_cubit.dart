import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile_app/models/Customer.dart';
import 'package:mobile_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

//const String Url = 'http://10.0.2.2:8080';
// const String Url = 'http://localhost:8080';
const String Url = 'https://torpedo-backend-production.up.railway.app';

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

      //print(response.data['myCustomer']);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      Customer loggedCustomer = Customer.fromJson(response.data['myCustomer']);
      await prefs.setBool('isLoggedIn', true);
      await _saveCustomer(loggedCustomer, response.data['jwt']);

      if (isClosed) return;
      emit(LoginSuccess(customer: loggedCustomer));
    } on DioException catch (e) {
      //print('Login Error');
      //print(e.toString());
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
      await _removeCustomer();

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
      Customer? customer = await loadCustomer();
      if (customer != null) {
        emit(LoginSuccess(customer: customer));
      } else {
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _saveCustomer(Customer customer, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = jsonEncode(customer.toJson());
    await prefs.setString('customer', customerJson);
    await prefs.setString('token', token);
  }

  Future<void> _removeCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('customer');
    await prefs.remove('token');
  }

  Future<Customer?> loadCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = prefs.getString('customer');
    if (customerJson != null) {
      final customerMap = jsonDecode(customerJson);
      return Customer.fromJson(customerMap);
    }
    return null;
  }
}
