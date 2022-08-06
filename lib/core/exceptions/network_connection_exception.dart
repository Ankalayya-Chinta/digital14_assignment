import 'package:digital14/core/exceptions/app_exception.dart';
import 'package:digital14/core/exceptions/exception_constants.dart';

class NetworkConnectionException extends AppException {
  NetworkConnectionException()
      : super(
          error: '',
          errorCode: ExceptionConstants.noNetwork,
        );
}
