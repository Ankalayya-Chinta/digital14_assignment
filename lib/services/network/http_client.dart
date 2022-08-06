import 'package:dio/dio.dart';
import 'package:digital14/core/exceptions/unauthorized_exception.dart';
import 'package:digital14/core/utils/http_util.dart';

class HttpClient {
  late Dio _client;
  String baseUrl;
  Map<String, String> header;

  HttpClient({
    required this.baseUrl,
    required this.header,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );
    _client = Dio(options);
  }

  String getParsedUrl(String path) {
    return '$baseUrl$path';
  }

  Dio get client => _client;

  dynamic get(String path) async {
    Response response;
    try {
      response = await _client.get(
        getParsedUrl(path),
        options: Options(headers: header),
      );
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) {
          throw UnauthorisedException();
        } else if (e.response?.statusCode == 401) {
          throw UnauthorisedException(
              error: e.response?.data is Map<String, dynamic>
                  ? e.response?.data['error_description']
                  : e.response?.statusMessage);
        } else {
          throw Exception(e.error);
        }
      }
      rethrow;
    }
    return HttpUtil.getResponse(response);
  }

  Map<String, String> generateRequestHeader([
    Map<String, String> overrideHeader = const {},
  ]) =>
      {
        ...header,
        ...overrideHeader,
      };

  void dispose() {
    _client.close();
  }
}
