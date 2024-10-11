part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

/******************************** Login *********************************/

final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {
  final DeliveryAgent? deliveryAgent;

  LoginSuccess({this.deliveryAgent});
}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
