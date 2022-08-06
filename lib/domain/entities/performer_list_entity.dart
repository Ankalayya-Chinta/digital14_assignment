import 'package:digital14/domain/entities/performer_entity.dart';

class PerformerListEntity {
  final List<PerformerEntity> performers;
  final int total;
  final int page;
  final int took;

  PerformerListEntity({
    required this.performers,
    required this.took,
    required this.page,
    required this.total,
  });

  factory PerformerListEntity.fromJson(Map<String, dynamic> json) {
    return PerformerListEntity(
      performers: json['performers'] != null
          ? (json['performers'] as List<dynamic>)
              .map((e) => PerformerEntity.fromJson(e))
              .toList()
          : [],
      took: json['meta']['took'],
      page: json['meta']['page'],
      total: json['meta']['total'],
    );
  }
}
