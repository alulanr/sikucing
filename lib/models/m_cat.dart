class CatModel {
  String? id;
  String name;
  String genders;
  String colors;
  String age;
  String city;
  String categories;
  bool isFavorited;
  String avatar;

  CatModel({
    this.id,
    required this.name,
    required this.genders,
    required this.colors,
    required this.age,
    required this.city,
    required this.categories,
    required this.isFavorited,
    required this.avatar,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json["id"] as String?,
      name: json["name"] as String,
      genders: json["genders"] as String,
      colors: json["colors"] as String,
      age: json["age"] as String,
      city: json["city"] as String,
      categories: json["categories"] as String,
      isFavorited: json["is_favorited"] == 1,
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "genders": genders,
      "colors": colors,
      "age": age,
      "city": city,
      "categories": categories,
      "is_favorited": false,
      "avatar": avatar,
    };
  }
}
