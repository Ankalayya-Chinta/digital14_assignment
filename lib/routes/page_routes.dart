import 'package:routemaster/routemaster.dart';
import 'package:digital14/presentation/not_found_page.dart';
import 'package:digital14/presentation/pages/performers/detail/performer_detail_page.dart';
import 'package:digital14/presentation/pages/performers/list/performers_list_page.dart';

/// Defines the base routing paths within the app.
///
/// Should generally be limited to the root pages of each [RouteMap].
class InitialPageRoutes {
  static const root = '/';
  static const notFound = '/404';
  static const performers = '/performers';
}

/// Defines the available page route names.
///
/// Valid paths should be declared within the relevant [PageRoutes] value.
/// When [Routemaster.push] is invoked with a [RelativePageRoute], it
/// will be treated as a relative path to the current path, and push the
/// page on top.
///
/// Pushing a page with a leading `/` implies an absolute path, so this
/// will replace the current navigation stack with the new route path.
///
/// See [Routemaster.push] for more information.
class RelativePageRoutes {
  static const details = 'details';
}

class PageRoutes {
  static final all = RouteMap(
    routes: {
      InitialPageRoutes.notFound: (routeData) => NotFoundPage(
            path: routeData.queryParameters['path'] ?? '',
          ),
      InitialPageRoutes.root: (routeData) => PerformersListPage(),
      '${InitialPageRoutes.performers}/:id': (routeData) {
        final performerId = _parseIntParam(routeData.pathParameters, 'id');
        if (performerId == null) {
          return PerformersListPage();
        } else {
          return PerformerDetailPage(performerId: performerId);
        }
      },
    },
  );

  static int? _parseIntParam(Map<String, String> params, String paramName) {
    final value = params[paramName];
    if (value != null && value.isNotEmpty) {
      return int.tryParse(value);
    }
    return null;
  }
}
