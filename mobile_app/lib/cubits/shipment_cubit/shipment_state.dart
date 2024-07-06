part of 'shipment_cubit.dart';

@immutable
sealed class ShipmentState {}

final class ShipmentInitial extends ShipmentState {}

final class ShipmentLoading extends ShipmentState {}

final class ShipmentSuccess extends ShipmentState {}

final class ShipmentFailure extends ShipmentState {
  final String errorMessage;

  ShipmentFailure({required this.errorMessage});
}
