import 'package:bloc/bloc.dart';
import 'package:delivery_agent_app/models/Shipment.dart';
import 'package:delivery_agent_app/services/ShipmentsService.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'shipment_state.dart';

// const String Url = 'http://10.0.2.2:8080';
// const String Url = 'http://localhost:8080';

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

  Future<void> getShipmentsByDeliveryAgentId() async {
    emit(ShipmentsLoading());
    try {
      List<Shipment> shipments =
          await ShipmentService(Dio()).getShipmentsByDeliveryAgentId();
      emit(ShipmentsLoaded(shipments: shipments));
    } on DioException catch (e) {
      emit(ShipmentsFailure(e.response!.data['message']));
    }
  }

  Future<void> searchShipments(id) async {
    if (id.toString() == '') {
      emit(ShipmentsInitial());
      return;
    }
    emit(ShipmentsLoading());
    try {
      List<Shipment> shipments =
          await ShipmentService(Dio()).getShipmentsByDeliveryAgentId();
      List<Shipment> filtered_shipments = [];
      for (Shipment shipment in shipments) {
        if (shipment.id.toString().contains(id.toString())) {
          filtered_shipments.add(shipment);
        }
      }
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
