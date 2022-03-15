import '../../global/constants/consts.dart';
import 'package:dio/dio.dart';

abstract class DioInstance {
  Dio get dioInstance;
}

//* since we need only all news, we can put the page size patameter in base options
class DioInstanceImpl implements DioInstance {
  @override
  Dio get dioInstance {
    final options = BaseOptions(
      baseUrl: newsApiBaseUrl,
      validateStatus: (status) => true,
      queryParameters: {
        'apiKey': newsApiToken,
        'pageSize': pageSize,
      },
      headers: {'Content-Type': 'application/json'},
      connectTimeout: 10000,
      receiveTimeout: 8000,
    );
    return Dio(options);
  }
}
