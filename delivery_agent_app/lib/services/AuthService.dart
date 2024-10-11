import 'dart:convert';

import 'package:delivery_agent_app/models/DeliveryAgent.dart';
import 'package:delivery_agent_app/models/User.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String Url = 'http://localhost:8080';
const String Url = 'https://torpedo-backend-production.up.railway.app';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  // agent login
  dynamic agentLogin(deliveryAgent) async {
    try {
      // login API here
      final response = await dio.post(
        '$Url/authenticate',
        data: deliveryAgent,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
      print(response.data['agent']);
      if (response.data['agent'] == null) {
        throw 'البيانات غير صحيحة';
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();

      DeliveryAgent loggedDeliveryAgent =
          DeliveryAgent.fromJson(response.data['agent']);
      await prefs.setBool('isLoggedIn', true);
      await _saveDeliveryAgent(loggedDeliveryAgent, response.data['jwt']);
      return loggedDeliveryAgent;
    } catch (e) {
      return e.toString();
    }
  }

  // agent logout
  dynamic agentLogout() async {
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
      await _removeDeliveryAgent();
    } on DioException catch (e) {
      // Handle logout error if necessary
    }
  }

  Future<void> _saveDeliveryAgent(
      DeliveryAgent deliveryAgent, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final deliveryAgentJson = jsonEncode(deliveryAgent.toJson());
    await prefs.setString('deliveryAgent', deliveryAgentJson);
    await prefs.setString('token', token);
  }

  Future<void> _removeDeliveryAgent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('deliveryAgent');
    await prefs.remove('token');
  }

  Future<DeliveryAgent?> loadDeliveryAgent() async {
    final prefs = await SharedPreferences.getInstance();
    final deliveryAgentJson = prefs.getString('deliveryAgent');
    if (deliveryAgentJson != null) {
      final deliveryAgentMap = jsonDecode(deliveryAgentJson);
      return DeliveryAgent.fromJson(deliveryAgentMap);
    }
    return null;
  }
}
