import 'package:delivery_agent_app/models/Pickup.dart';
import 'package:dio/dio.dart';

const String Url = 'http://10.0.2.2:8080';

class PickupService {
  final Dio dio;

  PickupService(this.dio);

  // get pickups
  dynamic getPickups() async {
    try {
      final response = await dio.get(
        '$Url/pickups',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      List<Pickup> pickups = [];
      for (var e in response.data) {
        Pickup pickup = Pickup.fromJson(e);
        pickups.add(pickup);
      }
      return pickups;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // get pickup by id
  dynamic getPickupById(id) async {
    try {
      final response = await dio.get(
        '$Url/pickups/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Pickup pickup = Pickup.fromJson(response.data);
      return pickup;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // create pickup
  dynamic createPickup(data) async {
    try {
      final response = await dio.post(
        '$Url/pickups',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response.data);
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // update pickup
  dynamic updatePickup(id, data) async {
    try {
      final response = await dio.put(
        '$Url/pickups/${id}',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // delete pickup
  dynamic deletePickup(id) async {
    try {
      final response = await dio.delete(
        '$Url/pickups/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      print(response);
    } on DioException catch (e) {
      return e.toString();
    }
  }
}
