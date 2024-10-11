import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_app/models/Shipment.dart';
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
        '$Url/shipment',
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
      return shipments;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get shipment by id
  dynamic getShipmentById(id) async {
    try {
      final response = await dio.get(
        '$Url/shipment/${id}',
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

  // get shipments by customer id
  dynamic getShipmentsByCustomerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? customer = prefs.getString(
        'customer'); // Assuming you store the customer ID as 'customerId'
    Map<String, dynamic> jsonMap = json.decode(customer!);
    int id = jsonMap['id'];
    dio.options.headers["Authorization"] = 'Bearer $token';
    try {
      final response = await dio.get(
        '$Url/shipment/customer/${id}',
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
      print(e.toString());
      return <Shipment>[];
      //return e.toString();
    }
  }

  // get shipments by delivery agent id
  dynamic getShipmentsByDeliveryAgentId(id) async {
    try {
      final response = await dio.get(
        '$Url/shipment/deliveryAgent/${id}',
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

  // create shipment
  dynamic createShipment(shipment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String? customer = prefs.getString(
        'customer'); // Assuming you store the customer ID as 'customerId'
    Map<String, dynamic> jsonMap = json.decode(customer!);
    int id = jsonMap['id'];
    dio.options.headers["Authorization"] = 'Bearer $token';

    try {
      // create item
      final item_response = await dio.post(
        '$Url/item',
        data: shipment['item'],
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print(item_response);
      print(item_response.data['data'][0]['id']);

      // create receiver
      final receiver_response = await dio.post(
        '$Url/receiver',
        data: shipment['receiver'],
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print(receiver_response);
      print(receiver_response.data['data'][0]['id']);

      shipment['shipment']['item']['id'] = item_response.data['data'][0]['id'];
      shipment['shipment']['receiver']['id'] =
          receiver_response.data['data'][0]['id'];
      ;
      shipment['shipment']['customer']['id'] = id;

      final response = await dio.post(
        '$Url/shipment',
        data: shipment['shipment'],
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  // update shipment
  dynamic updateShipment(id, shipment) async {
    try {
      final response = await dio.put(
        '$Url/shipment/${id}',
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
        '$Url/shipment/${id}',
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
