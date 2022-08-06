import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital14/blocs/performers_bloc.dart';
import 'package:digital14/presentation/widgets/error_view.dart';
import 'package:digital14/presentation/widgets/loader_view.dart';

class PerformerDetailView extends StatelessWidget {
  const PerformerDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformersBloc, PerformersState>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Builder(builder: (_) {
              return Text(
                state is LoadedPerformerDetailState ? state.data.name : '',
              );
            }),
            actions: [
              if (state is LoadedPerformerDetailState)
                IconButton(
                  onPressed: () => context.read<PerformersBloc>()
                    ..updateFavorite(
                      state.data,
                    ),
                  icon: Icon(
                    state.data.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
            ],
          ),
          body: Builder(builder: (_) {
            if (state is LoadedPerformerDetailState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity, height: 16),
                    CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.3,
                      imageUrl: state.data.getThumbnail(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.data.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 2),
                    Text(state.data.type),
                  ],
                ),
              );
            } else if (state is ErrorPerformersState) {
              return ErrorView(message: state.error);
            } else {
              return const LoaderView();
            }
          }),
        );
      },
    );
  }
}
