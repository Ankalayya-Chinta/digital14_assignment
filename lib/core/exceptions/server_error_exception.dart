import 'package:digital14/core/exceptions/app_exception.dart';
import 'package:digital14/core/exceptions/exception_constants.dart';

class ServerErrorException extends AppException {
  ServerErrorException(error)
      : super(
          error: error,
          errorCode: ExceptionConstants.internalServerError,
        );
}
