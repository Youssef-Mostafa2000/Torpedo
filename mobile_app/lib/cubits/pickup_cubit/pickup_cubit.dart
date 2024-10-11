import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/models/Pickup.dart';
import 'package:mobile_app/services/PickupService.dart';

part 'pickup_state.dart';

class PickupCubit extends Cubit<PickupState> {
  PickupCubit() : super(PickupInitial());

  Future<void> createPickup(data) async {
    emit(PickupsLoading());
    try {
      await PickupService(Dio()).createPickup(data);
      emit(PickupsLoaded());
      // loadPickups();
    } catch (e) {
      emit(PickupsFailure(e.toString()));
    }
  }

  Future<void> loadPickups() async {
    emit(PickupsLoading());
    try {
      List<Pickup> pickups =
          await PickupService(Dio()).getPickupsByCustomerId();
      emit(PickupsLoaded(pickups: pickups));
    } catch (e) {
      emit(PickupsFailure(e.toString()));
    }
  }

  Future<void> getPickupsByCustomerId() async {
    emit(PickupsLoading());
    try {
      List<Pickup> pickups =
          await PickupService(Dio()).getPickupsByCustomerId();
      emit(PickupsLoaded(pickups: pickups));
    } catch (e) {
      emit(PickupsFailure(e.toString()));
    }
  }

  Future<void> getPickup(id) async {
    emit(PickupLoading());
    try {
      Pickup pickup = await PickupService(Dio()).getPickupById(id);
      emit(PickupLoaded(pickup));
    } catch (e) {
      emit(PickupFailure(e.toString()));
    }
  }

  Future<void> searchPickups(data) async {
    if (data['id'].toString() == '') {
      emit(PickupsInitial());
      return;
    }
    emit(PickupsLoading());
    try {
      List<Pickup> pickups =
          await PickupService(Dio()).getPickupsByCustomerId();
      List<Pickup> filtered_pickups = [];
      for (Pickup pickup in pickups) {
        if (pickup.id.toString().contains(data['id'].toString()) ||
            pickup.status == data['status']) {
          filtered_pickups.add(pickup);
        }
      }
      emit(PickupsLoaded(pickups: filtered_pickups));
    } on DioException catch (e) {
      emit(PickupsFailure(e.response!.data['message']));
    }
  }

  Future<void> updatePickup(id, data) async {
    emit(PickupLoading());
    try {
      await PickupService(Dio()).updatePickup(id, data);
      // loadPickups();
      emit(PickupsLoaded());
    } catch (e) {
      emit(PickupFailure(e.toString()));
    }
  }

  Future<void> deletePickup(id) async {
    emit(PickupLoading());
    try {
      await PickupService(Dio()).deletePickup(id);
      // loadPickups();
      emit(PickupsLoaded());
    } catch (e) {
      emit(PickupFailure(e.toString()));
    }
  }
}
