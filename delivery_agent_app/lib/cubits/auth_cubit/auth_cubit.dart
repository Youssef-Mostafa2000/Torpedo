import 'package:bloc/bloc.dart';
import 'package:delivery_agent_app/models/DeliveryAgent.dart';
import 'package:delivery_agent_app/models/User.dart';
import 'package:delivery_agent_app/services/AuthService.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

const String Url = 'http://localhost:8080';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> deliveryAgentLogin(deliveryAgent) async {
    emit(LoginLoading());
    try {
      final agent = await AuthService(Dio()).agentLogin(deliveryAgent);
      emit(LoginSuccess(deliveryAgent: agent));
    } on DioException catch (e) {
      //print('Login Error');
      //print(e.toString());
      if (isClosed) return;
      emit(LoginFailure(
          errorMessage: e.response?.data['message'] ?? 'An error occurred'));
    }
  }

  Future<void> deliveryAgentLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      await AuthService(Dio()).agentLogout();
      if (isClosed) return;
      emit(AuthInitial());
    } catch (e) {}
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print('checking login');
    if (isLoggedIn) {
      DeliveryAgent? deliveryAgent =
          await AuthService(Dio()).loadDeliveryAgent();
      if (deliveryAgent != null) {
        emit(LoginSuccess(deliveryAgent: deliveryAgent));
      } else {
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }
}
