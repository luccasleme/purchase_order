class HomeModel {
  final String image;
  final String name;
  final String id;

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      image: json['urlIconListFilter'],
      name: json['processKey'],
      id: json['id'].toString(),
    );
  }

  HomeModel({required this.image, required this.name, required this.id});
}
