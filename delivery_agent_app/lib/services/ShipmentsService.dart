import 'dart:convert';

import 'package:delivery_agent_app/models/Shipment.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String Url = 'http://10.0.2.2:8080';
// const String Url = 'http://localhost:8080';
const String Url = 'https://torpedo-backend-production.up.railway.app';

class ShipmentService {
  final Dio dio;

  ShipmentService(this.dio);

  // get all shipments
  dynamic getShipments() async {
    try {
      final response = await dio.get(
        '$Url/shipments',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      List<Shipment> shipments = [];
      for (var e in response.data) {
        Shipment shipment = Shipment.fromJson(e);
        shipments.add(shipment);
      }
      return shipments;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get shipment by id
  dynamic getShipmentById(id) async {
    try {
      final response = await dio.get(
        '$Url/shipments/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Shipment shipment = Shipment.fromJson(response.data);
      return shipment;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get shipment by id
  dynamic getShipmentsByDeliveryAgentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? deliveryAgent = prefs.getString(
        'deliveryAgent'); // Assuming you store the customer ID as 'customerId'
    Map<String, dynamic> jsonMap = json.decode(deliveryAgent!);
    int id = jsonMap['id'];
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.get(
        '$Url/shipments/deliveryAgent/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
      List<Shipment> shipments = [];
      for (var e in response.data['data']) {
        Shipment shipment = Shipment.fromJson(e);
        shipments.add(shipment);
      }
      print(shipments);
      return shipments;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // create shipment
  dynamic createShipment(shipment) async {
    try {
      final response = await dio.post(
        '$Url/shipments',
        data: shipment,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {}
  }

  // update shipment
  dynamic updateShipment(id, shipment) async {
    try {
      final response = await dio.put(
        '$Url/shipments/${id}',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Shipment shipment = Shipment.fromJson(response.data);
      return shipment;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // delete shipment
  dynamic deleteShipment(id) async {
    try {
      final response = await dio.delete(
        '$Url/shipments/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {}
  }
}
