import 'dart:convert';

import 'http_client.dart';

class MobileClient extends HttpClient {
  final String clientId;
  final String clientSecert;

  MobileClient({
    required String baseUrl,
    required this.clientId,
    required this.clientSecert,
  }) : super(
          baseUrl: baseUrl,
          header: {
            'Authorization': 'Basic ' +
                base64.encode(utf8.encode('$clientId:$clientSecert')),
          },
        );
}
