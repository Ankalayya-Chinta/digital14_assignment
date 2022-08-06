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
      return 'https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI';
    } else {
      return 'https://i.picsum.photos/id/1071/3000/1996.jpg?hmac=rPo94Qr1Ffb657k6R7c9Zmfgs4wc4c1mNFz7ND23KnQ';
    }
  }
}
