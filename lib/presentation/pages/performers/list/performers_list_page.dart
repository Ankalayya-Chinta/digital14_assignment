import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital14/blocs/performers_bloc.dart';
import 'package:digital14/presentation/base_page.dart';
import 'package:digital14/presentation/pages/performers/list/performers_list_view.dart';
import 'package:digital14/routes/page_routes.dart';

class PerformersListPage extends BasePage<void> {
  PerformersListPage()
      : super(
          keyValue: InitialPageRoutes.root,
          routeName: InitialPageRoutes.root,
        );

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => BlocProvider(
        create: (_) => PerformersBloc(),
        child: const PerformersListView(),
      ),
    );
  }
}
