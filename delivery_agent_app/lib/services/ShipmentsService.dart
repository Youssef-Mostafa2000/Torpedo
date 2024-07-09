import 'package:delivery_agent_app/models/Shipment.dart';
import 'package:dio/dio.dart';

const String Url = 'http://10.0.2.2:8080';

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
