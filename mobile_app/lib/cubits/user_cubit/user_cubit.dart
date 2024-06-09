import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

const String Url = 'http://10.0.2.2:8080';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getUser(int id) async {
    Dio dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer ${token}';
    try {
      emit(UserLoading());
      Dio dio = new Dio();
      final response = await dio.get(
        '$Url/customer/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        User fetchedUser = User.fromJson(response.data);
        emit(UserSuccess(user: fetchedUser));
      }
    } on DioException catch (e) {
      print(e.toString());
      emit(UserFailure(errorMessage: e.response!.data['message']));
    }
  }

  Future<void> updateUser(id, user) async {
    Dio dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    dio.options.headers["Authorization"] = 'Bearer ${token}';
    try {
      emit(UserLoading());
      Dio dio = new Dio();
      final response = await dio.post(
        '$Url/customer/$id',
        data: user,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      print(e.toString());
      emit(UserFailure(errorMessage: e.response!.data['message']));
    }
  }
}
