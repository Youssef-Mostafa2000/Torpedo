import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_app/models/Pickup.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String Url = 'http://10.0.2.2:8080';
// const String Url = 'http://localhost:8080';
const String Url = 'https://torpedo-backend-production.up.railway.app';

class PickupService {
  final Dio dio;

  PickupService(this.dio);

  // get pickups
  dynamic getPickups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.get(
        '$Url/pickup',
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

  // get pickup by id
  dynamic getPickupById(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.get(
        '$Url/pickup/${id}',
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

  // get pickups by customer id
  dynamic getPickupsByCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String? customer = prefs.getString(
        'customer'); // Assuming you store the customer ID as 'customerId'
    Map<String, dynamic> jsonMap = json.decode(customer!);
    int id = jsonMap['id'];
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.get(
        '$Url/pickup/customer/${id}',
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
      print(response.data);
      return pickups;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get pickups by delivery agent id
  dynamic getPickupsByDeliveryAgentId(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer $token';

    try {
      final response = await dio.get(
        '$Url/pickup/agent/${id}',
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

  // create pickup
  dynamic createPickup(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? customer = prefs.getString(
        'customer'); // Assuming you store the customer ID as 'customerId'
    Map<String, dynamic> jsonMap = json.decode(customer!);
    int id = jsonMap['id'];
    // print("****************" + (id).toString());

    dio.options.headers["Authorization"] = 'Bearer $token';
    data['customer'] = {'id': id}; // Add customer ID to the data
    print(data);
    try {
      final response = await dio.post(
        '$Url/pickup',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print('pickup created successfully\n');
      print(response.data);
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // update pickup
  dynamic updatePickup(id, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.put(
        '$Url/pickup/${id}',
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.delete(
        '$Url/pickup/${id}',
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
