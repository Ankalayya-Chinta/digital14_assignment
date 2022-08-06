import 'package:flutter/material.dart';
import 'package:digital14/presentation/base_page.dart';
import 'package:digital14/routes/page_routes.dart';

class NotFoundPage extends BasePage<void> {
  /// The invalid route path that was pushed.
  final String path;

  NotFoundPage({
    required this.path,
    String routeName = InitialPageRoutes.notFound,
  }) : super(keyValue: path, routeName: '$routeName: $path');

  @override
  Route<void> createRoute(BuildContext context) => MaterialPageRoute(
        settings: this,
        builder: (context) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '404',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We coundn\'t find this page',
                  ),
                  Text(path),
                ],
              ),
            ),
          );
        },
      );
}
