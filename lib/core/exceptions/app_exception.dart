class AppException implements Exception {
  final String error;
  final String? errorCode;

  AppException({required this.error, this.errorCode});

  @override
  String toString() => error;
}
