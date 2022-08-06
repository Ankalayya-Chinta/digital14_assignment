import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:digital14/core/exceptions/app_exception.dart';
import 'package:digital14/core/exceptions/bad_request_exception.dart';
import 'package:digital14/core/exceptions/server_error_exception.dart';
import 'package:digital14/core/exceptions/unauthorized_exception.dart';

class HttpUtil {
  static dynamic encodeRequestBody(dynamic data, String contentType) {
    return contentType == 'application/json'
        ? utf8.encode(json.encode(data))
        : data;
  }

  static dynamic getResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return _getSuccessResponse(response);
      case 204:
        return null;
      case 400:
        throw BadRequestException(error: response.data);
      case 401:
      case 403:
        throw UnauthorisedException(
          error: _parseErrorResponse(response),
        );
      case 404:
        throw BadRequestException(
          error: _parseErrorResponse(response),
        );
      case 405:
        throw ServerErrorException(
          _parseErrorResponse(response),
        );
      case 500:
      default:
        throw ServerErrorException(
          _parseErrorResponse(response),
        );
    }
  }

  static _parseErrorResponse(Response response) {
    if (response.data.isEmpty) {
      return response.data.toString();
    } else {
      return response.data['message'];
    }
  }

  static dynamic _getSuccessResponse(Response response) {
    if (response.data.isEmpty) {
      throw AppException(error: "Bad response from server");
    }
    return response.data;
  }
}
