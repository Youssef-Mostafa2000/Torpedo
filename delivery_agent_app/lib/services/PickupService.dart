import 'dart:convert';

import 'package:delivery_agent_app/models/Pickup.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String Url = 'http://10.0.2.2:8080';
// const String Url = 'http://localhost:8080';
const String Url = 'https://torpedo-backend-production.up.railway.app';

class PickupService {
  final Dio dio;

  PickupService(this.dio);

  // get pickups
  dynamic getPickups() async {
    try {
      final response = await dio.get(
        '$Url/pickups',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      List<Pickup> pickups = [];
      for (var e in response.data) {
        Pickup pickup = Pickup.fromJson(e);
        pickups.add(pickup);
      }
      return pickups;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get pickup by id
  dynamic getPickupById(id) async {
    try {
      final response = await dio.get(
        '$Url/pickups/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Pickup pickup = Pickup.fromJson(response.data);
      return pickup;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get pickup by id
  dynamic getPickupsByDeliveryAgentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? deliveryAgent = prefs.getString('deliveryAgent');
    Map<String, dynamic> jsonMap = json.decode(deliveryAgent!);
    int id = jsonMap['id'];
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.get(
        '$Url/pickups/deliveryAgent/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      List<Pickup> pickups = [];
      for (var e in response.data['data']) {
        Pickup pickup = Pickup.fromJson(e);
        pickups.add(pickup);
      }
      return pickups;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // create pickup
  dynamic createPickup(data) async {
    try {
      final response = await dio.post(
        '$Url/pickups',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response.data);
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // update pickup
  dynamic updatePickup(id, data) async {
    try {
      final response = await dio.put(
        '$Url/pickups/${id}',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // delete pickup
  dynamic deletePickup(id) async {
    try {
      final response = await dio.delete(
        '$Url/pickups/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
    } on DioException catch (e) {
      return e.toString();
    }
  }
}
