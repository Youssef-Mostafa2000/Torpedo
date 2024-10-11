import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/models/Shipment.dart';
import 'package:mobile_app/services/ShipmentsService.dart';

part 'shipment_state.dart';

const String Url = 'http://10.0.2.2:8080';

class ShipmentCubit extends Cubit<ShipmentState> {
  ShipmentCubit() : super(ShipmentInitial());

  Future<void> createShipment(shipment) async {
    emit(ShipmentLoading());
    try {
      ShipmentService(Dio()).createShipment(shipment);
      // loadShipments();
      emit(ShipmentsLoaded());
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }

  Future<void> loadShipments() async {
    emit(ShipmentsLoading());
    try {
      List<Shipment> shipments = await ShipmentService(Dio()).getShipments();
      print(shipments);
      emit(ShipmentsLoaded(shipments: shipments));
    } on DioException catch (e) {
      emit(ShipmentsFailure(e.response!.data['message']));
    }
  }

  Future<void> getShipment(id) async {
    emit(ShipmentLoading());
    try {
      Shipment shipment = await ShipmentService(Dio()).getShipmentById(id);
      emit(ShipmentLoaded(shipment));
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }

  Future<void> getShipmentsByCustomerId() async {
    emit(ShipmentsLoading());
    try {
      List<Shipment> shipments =
          await ShipmentService(Dio()).getShipmentsByCustomerId() ??
              <Shipment>[];
      emit(ShipmentsLoaded(shipments: shipments));
    } on DioException catch (e) {
      emit(ShipmentsFailure(e.response!.data['message']));
    }
  }

  Future<void> searchShipments(data) async {
    if (data['id'].toString() == '') {
      emit(ShipmentsInitial());
      return;
    }
    emit(ShipmentsLoading());
    try {
      List<Shipment> shipments =
          await ShipmentService(Dio()).getShipmentsByCustomerId();
      List<Shipment> filtered_shipments = [];
      for (Shipment shipment in shipments) {
        if (shipment.id.toString().contains(data['id'].toString()) ||
            shipment.status == data['status'] ||
            shipment.receiver!.city == data['city']) {
          filtered_shipments.add(shipment);
        }
      }
      print(filtered_shipments);
      emit(ShipmentsLoaded(shipments: filtered_shipments));
    } on DioException catch (e) {
      emit(ShipmentsFailure(e.response!.data['message']));
    }
  }

  Future<void> updateShipment(id, shipment) async {
    emit(ShipmentLoading());
    try {
      ShipmentService(Dio()).updateShipment(id, shipment);
      // loadShipments();
      emit(ShipmentsLoaded());
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }

  Future<void> deleteShipment(id) async {
    emit(ShipmentLoading());
    try {
      ShipmentService(Dio()).deleteShipment(id);
      // loadShipments();
      emit(ShipmentsLoaded());
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }
}
