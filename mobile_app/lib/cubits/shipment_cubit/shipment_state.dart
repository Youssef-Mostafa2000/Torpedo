part of 'shipment_cubit.dart';

@immutable
sealed class ShipmentState {
  const ShipmentState();

  @override
  List<Object> get props => [];
}

final class ShipmentsInitial extends ShipmentState {}

final class ShipmentsLoading extends ShipmentState {}

final class ShipmentsLoaded extends ShipmentState {
  final List<Shipment> shipments;

  const ShipmentsLoaded(this.shipments);

  @override
  List<Object> get props => [shipments];
}

final class ShipmentsFailure extends ShipmentState {
  final String errorMessage;

  const ShipmentsFailure(this.errorMessage);
}

/********************************* Single Shipment *************************************/

final class ShipmentInitial extends ShipmentState {}

final class ShipmentLoading extends ShipmentState {}

final class ShipmentLoaded extends ShipmentState {
  final Shipment shipment;

  const ShipmentLoaded(this.shipment);
}

final class ShipmentFailure extends ShipmentState {
  final String errorMessage;

  const ShipmentFailure(this.errorMessage);
}
