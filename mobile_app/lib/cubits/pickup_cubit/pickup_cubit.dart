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
      PickupService(Dio()).createPickup(data);
      loadPickups();
    } catch (e) {
      emit(PickupsFailure(e.toString()));
    }
  }

  Future<void> loadPickups() async {
    emit(PickupsLoading());
    try {
      List<Pickup> pickups = PickupService(Dio()).getPickups();
      emit(PickupsLoaded(pickups));
    } catch (e) {
      emit(PickupsFailure(e.toString()));
    }
  }

  Future<void> getPickup(id) async {
    emit(PickupLoading());
    try {
      Pickup pickup = PickupService(Dio()).getPickupById(id);
      emit(PickupLoaded(pickup));
    } catch (e) {
      emit(PickupFailure(e.toString()));
    }
  }

  Future<void> updatePickup(id, data) async {
    emit(PickupLoading());
    try {
      PickupService(Dio()).updatePickup(id, data);
      loadPickups();
    } catch (e) {
      emit(PickupFailure(e.toString()));
    }
  }

  Future<void> deletePickup(id) async {
    emit(PickupLoading());
    try {
      PickupService(Dio()).deletePickup(id);
      loadPickups();
    } catch (e) {
      emit(PickupFailure(e.toString()));
    }
  }
}
