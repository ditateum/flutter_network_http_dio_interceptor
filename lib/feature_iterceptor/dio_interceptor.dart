import 'package:dio/dio.dart';
import 'package:network_playground/feature_iterceptor/store_service.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await StoreService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
