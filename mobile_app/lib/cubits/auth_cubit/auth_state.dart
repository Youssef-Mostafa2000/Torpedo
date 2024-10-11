part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

/******************************** Register *********************************/

final class RegisterInitial extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterFailure extends AuthState {
  final String errorMessage;

  RegisterFailure({required this.errorMessage});
}

/******************************** Login *********************************/

final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {
  final Customer? customer;

  LoginSuccess({this.customer});
}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
