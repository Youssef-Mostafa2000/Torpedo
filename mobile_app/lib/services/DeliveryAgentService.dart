import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_app/models/DeliveryAgent.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String Url = 'https://torpedo-backend-production.up.railway.app';

class DeliveryAgentService {
  final Dio dio;

  DeliveryAgentService(this.dio);

  dynamic getDeliveryAgent(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String? customer = prefs.getString(
        'customer'); // Assuming you store the customer ID as 'customerId'
    Map<String, dynamic> jsonMap = json.decode(customer!);
    int id = jsonMap['id'];
    dio.options.headers["Authorization"] = 'Bearer $token';

    try {
      final response = await dio.get(
        '$Url/agent/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      DeliveryAgent deliveryAgent =
          DeliveryAgent.fromJson(response.data['data'][0]);
      return deliveryAgent;
    } on DioException catch (e) {
      return e.toString();
    }
  }
}
