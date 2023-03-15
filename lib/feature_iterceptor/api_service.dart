import 'package:dio/dio.dart';
import 'package:network_playground/feature_iterceptor/dio_interceptor.dart';
import 'package:network_playground/feature_iterceptor/store_service.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _loginUrl =
      'http://restapi.adequateshop.com/api/authaccount/login';

  final String _dataUrl = 'http://restapi.adequateshop.com/api/users?page=1';

  Map<String, dynamic> get _loginData => {
        "email": "Developer5@gmail.com",
        "password": 123456,
      };

  Future<void> _saveToken(Map<String, dynamic> data) async {
    final token = data["data"]["Token"];
    await StoreService.setToken(token);
  }

  String _getResult(Map<String, dynamic> json) {
    final List<dynamic> list = json["data"];
    return "Received ${list.length} object";
  }

  Future<bool> dioLogin() async {
    final response = await _dio.post(
      _loginUrl,
      data: _loginData,
    );

    if (response.statusCode == 200) {
      await _saveToken(response.data);
      return true;
    }

    return false;
  }

  Future<String> dioGetData() async {
    try {
      final response = await _dio.get(
        _dataUrl,
      );

      if (response.statusCode == 200) {
        return _getResult(response.data);
      }

      return response.data as String;
    } on DioError catch (e) {
      return e.response?.data ?? 'Error occured';
    }
  }
}
