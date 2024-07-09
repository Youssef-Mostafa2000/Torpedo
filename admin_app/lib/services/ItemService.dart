import 'package:admin_app/models/Item.dart';
import 'package:dio/dio.dart';

const String Url = 'http://10.0.2.2:8080';

class ItemService {
  final Dio dio;

  ItemService(this.dio);

  // get item
  dynamic getItem(id) async {
    try {
      final response = await dio.get(
        '$Url/items/${id}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      Item item = Item.fromJson(response.data);
      return item;
    } on DioException catch (e) {
      return e.toString();
    }
  }

  // create item
  dynamic createItem(item) async {
    try {
      final response = await dio.post(
        '$Url/items',
        data: item,
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
