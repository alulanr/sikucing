import 'package:dio/dio.dart';
import 'package:sikucing/models/m_cat.dart';
import 'package:sikucing/helpers/api_client.dart';

class CatService {
  final Dio _dio = ApiClient().dio;

  Future<List<CatModel>> listData() async {
    try {
      final Response response = await _dio.get('cats');
      final List<dynamic> data = response.data;
      final List<CatModel> result =
          data.map((json) => CatModel.fromJson(json)).toList();

      return result;
    } catch (error) {
      rethrow;
    }
  }
}
