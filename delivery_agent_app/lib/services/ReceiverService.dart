import 'package:delivery_agent_app/models/Receiver.dart';
import 'package:dio/dio.dart';

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
        '$Url/receivers/${id}',
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
        '$Url/receivers',
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
