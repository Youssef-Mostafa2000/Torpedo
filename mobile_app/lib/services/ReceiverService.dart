import 'package:dio/dio.dart';
import 'package:mobile_app/models/Receiver.dart';

// const String Url = 'http://10.0.2.2:8080';
// const String Url = 'http://localhost:8080';
const String Url = 'https://torpedo-backend-production.up.railway.app';

class ReceiverService {
  final Dio dio;

  ReceiverService(this.dio);

  // get receiver
  dynamic getReceiver(id) async {
    try {
      final response = await dio.post(
        '$Url/receiver/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Receiver receiver = Receiver.fromJson(response.data);
      return receiver;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // create receiver
  dynamic createReceiver(receiver) async {
    try {
      final response = await dio.post(
        '$Url/receiver',
        data: receiver,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      return e.toString();
    }
  }
}
