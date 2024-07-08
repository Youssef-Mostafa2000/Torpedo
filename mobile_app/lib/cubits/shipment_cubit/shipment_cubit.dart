import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
      loadShipments();
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }

  Future<void> loadShipments() async {
    emit(ShipmentsLoading());
    try {
      List<Shipment> shipments = ShipmentService(Dio()).getShipments();
      print(shipments);
      emit(ShipmentsLoaded(shipments));
    } on DioException catch (e) {
      emit(ShipmentsFailure(e.response!.data['message']));
    }
  }

  Future<void> getShipment(id) async {
    emit(ShipmentLoading());
    try {
      Shipment shipment = ShipmentService(Dio()).getShipmentById(id);
      emit(ShipmentLoaded(shipment));
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }

  Future<void> updateShipment(id, shipment) async {
    emit(ShipmentLoading());
    try {
      ShipmentService(Dio()).updateShipment(id, shipment);
      loadShipments();
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }

  Future<void> deleteShipment(id) async {
    emit(ShipmentLoading());
    try {
      ShipmentService(Dio()).deleteShipment(id);
      loadShipments();
    } on DioException catch (e) {
      emit(ShipmentFailure(e.response!.data['message']));
    }
  }
}
