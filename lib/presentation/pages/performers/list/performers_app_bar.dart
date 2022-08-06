import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital14/blocs/performers_bloc.dart';
import 'package:digital14/presentation/pages/performers/performer_consts.dart';
import 'package:digital14/presentation/widgets/c_app_bar.dart';

class PerformersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _focusNode = FocusNode();
  final Function(String value) onSearch;

  PerformersAppBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerformersBloc, PerformersState>(
      listener: (_, state) {
        if (state is MovedToPageState) {
          if (state.isSearch) {
            _focusNode.requestFocus();
          } else {
            _focusNode.unfocus();
          }
        }
      },
      buildWhen: (_, current) => current is MovedToPageState,
      builder: (_, state) {
        return (state as MovedToPageState).isSearch
            ? CAppBar.search(
                context,
                focusNode: _focusNode,
                onCancelPressed: () =>
                    context.read<PerformersBloc>()..goToHome(),
                onTextEntered: onSearch,
              )
            : CAppBar.home(
                context,
                title: PerformerConsts.performers,
                onSearchPressed: () =>
                    context.read<PerformersBloc>()..goToSearch(),
              );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
