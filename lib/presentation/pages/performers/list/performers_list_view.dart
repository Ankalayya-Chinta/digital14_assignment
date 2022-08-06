import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:routemaster/routemaster.dart';
import 'package:digital14/blocs/performers_bloc.dart';
import 'package:digital14/domain/entities/performer_entity.dart';
import 'package:digital14/presentation/pages/performer_item_view.dart';
import 'package:digital14/presentation/pages/performers/list/performers_app_bar.dart';
import 'package:digital14/presentation/widgets/error_view.dart';
import 'package:digital14/presentation/widgets/loader_view.dart';
import 'package:digital14/routes/page_routes.dart';

class PerformersListView extends StatefulWidget {
  const PerformersListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PerformersListViewState();
}

class _PerformersListViewState extends State<PerformersListView> {
  Timer? _debounce;
  bool _isInSearch = false;
  String _searchText = '';
  final _recordsPerPage = 25;
  int _pageId = 1;
  final PagingController<int, PerformerEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PerformersAppBar(onSearch: _handleSearch),
      body: BlocListener<PerformersBloc, PerformersState>(
        listener: (_, state) {
          if (state is LoadedPerformersState) {
            final isLastPage = state.data.length < _recordsPerPage;
            if (isLastPage) {
              _pagingController.appendLastPage(state.data);
            } else {
              final nextPageKey = _pageId + 1;
              _pagingController.appendPage(state.data, nextPageKey);
            }
          } else if (state is ErrorPerformersState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              _pagingController.error = state.error;
            });
          } else if (state is MovedToPageState) {
            _isInSearch = state.isSearch;
            _searchText = '';
            _pageId = 1;
            _pagingController.refresh();
          }
        },
        child: PagedListView<int, PerformerEntity>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<PerformerEntity>(
            firstPageProgressIndicatorBuilder: (_) => const LoaderView(),
            newPageProgressIndicatorBuilder: (_) => const LoaderView(),
            noItemsFoundIndicatorBuilder: (_) => ErrorView(
              message: _pagingController.error,
            ),
            firstPageErrorIndicatorBuilder: (context) {
              return ErrorView(message: _pagingController.error);
            },
            itemBuilder: (context, item, index) => PerformerItemView(
              item: item,
              onTap: () => Routemaster.of(context)
                  .push(
                    '${InitialPageRoutes.performers}/${item.id}',
                  )
                  .result
                  .then((value) => context.read<PerformersBloc>().refresh()),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageId) async {
    _pageId = pageId;
    if (_isInSearch) {
      return await context
          .read<PerformersBloc>()
          .getPerformers(pageId, searchText: _searchText);
    } else {
      return await context.read<PerformersBloc>().getPerformers(pageId);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _handleSearch(String value) {
    _pageId = 1;
    _searchText = value;
    if (_debounce != null) _debounce?.cancel();
    setState(() {
      _debounce = Timer(const Duration(milliseconds: 100), () {
        _pagingController.refresh();
      });
    });
  }
}
