part of 'pickup_cubit.dart';

@immutable
sealed class PickupState {}

final class PickupsInitial extends PickupState {}

final class PickupsLoading extends PickupState {}

final class PickupsLoaded extends PickupState {
  final List<Pickup> pickups;

  PickupsLoaded(this.pickups);
}

final class PickupsFailure extends PickupState {
  final String errorMessage;

  PickupsFailure(this.errorMessage);
}

/********************************* Single Pickup *********************************/

final class PickupInitial extends PickupState {}

final class PickupLoading extends PickupState {}

final class PickupLoaded extends PickupState {
  final Pickup pickup;

  PickupLoaded(this.pickup);
}

final class PickupFailure extends PickupState {
  final String errorMessage;

  PickupFailure(this.errorMessage);
}
