import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'shipment_state.dart';

class ShipmentCubit extends Cubit<ShipmentState> {
  ShipmentCubit() : super(ShipmentInitial());

  Future<void> createShipment() async {
    emit(ShipmentLoading());
    try {
      // create shipment api
    } on DioException catch (e) {
      emit(ShipmentFailure(errorMessage: e.response!.data['message']));
    }
  }

  Future<void> getShipments() async {}

  Future<void> getShipment() async {}

  Future<void> updateShipment() async {}

  Future<void> deleteShipment() async {}
}
