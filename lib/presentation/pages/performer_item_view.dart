import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital14/blocs/performers_bloc.dart';
import 'package:digital14/domain/entities/performer_entity.dart';

class PerformerItemView extends StatelessWidget {
  final VoidCallback onTap;
  final PerformerEntity item;

  const PerformerItemView({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        height: 40,
        width: 40,
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
        imageUrl: item.getThumbnail(),
      ),
      onTap: onTap,
      title: Text(item.name),
      subtitle: Text(item.type),
      trailing: IconButton(
        onPressed: () => context.read<PerformersBloc>()..updateFavorite(item),
        icon: Icon(
          item.isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
      ),
    );
  }
}
