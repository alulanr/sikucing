import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://653a5c1ae3b530c8d9e98dcf.mockapi.io/sikucing/',
  ));

  Future<Response> get(String path) async {
    try {
      final response = await dio.get(path);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
