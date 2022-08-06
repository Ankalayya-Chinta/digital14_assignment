import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital14/blocs/performers_bloc.dart';
import 'package:digital14/presentation/base_page.dart';
import 'package:digital14/presentation/pages/performers/detail/performer_detail_view.dart';
import 'package:digital14/routes/page_routes.dart';

class PerformerDetailPage extends BasePage<void> {
  final int performerId;

  PerformerDetailPage({required this.performerId})
      : super(
          keyValue: InitialPageRoutes.performers,
          routeName: InitialPageRoutes.performers,
        );

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => BlocProvider(
        create: (_) => PerformersBloc()..getPerformerDetail(performerId),
        child: const PerformerDetailView(),
      ),
    );
  }
}
