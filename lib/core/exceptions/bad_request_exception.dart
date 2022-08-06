import 'package:digital14/core/exceptions/app_exception.dart';
import 'package:digital14/core/exceptions/exception_constants.dart';

class BadRequestException extends AppException {
  BadRequestException({String? error})
      : super(
          error: error ?? '',
          errorCode: ExceptionConstants.badRequest,
        );
}
