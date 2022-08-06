class PerformerEntity {
  int id;
  String name;
  String type;
  bool isFavorite;

  PerformerEntity({
    required this.id,
    required this.name,
    required this.type,
    this.isFavorite = false,
  });

  factory PerformerEntity.fromJson(Map<String, dynamic> data) {
    return PerformerEntity(
      id: data['id'],
      name: data['name'],
      type: data['type'],
    );
  }

  String getThumbnail() {
    if (id % 2 == 0) {
      return 'https://dwpinsider.com/blog/wp-content/uploads/2022/06/dwpinsideralhiweddings.jpg';
    } else {
      return 'https://images.squarespace-cdn.com/content/v1/5b778e4d55b02c576cf5dd73/1617001092185-P7YO3WF5EMLANARD9IKS/Paradise+Cove+Oceanside+Wedding+Reception?format=1000w';
    }
  }
}
