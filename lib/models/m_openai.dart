class AboutCatModel {
  final String title;
  final String description;

  AboutCatModel({
    required this.title,
    required this.description,
  });

  factory AboutCatModel.fromJson(Map<String, dynamic> json) {
    return AboutCatModel(
      title: json['title'],
      description: json['description'],
    );
  }
}
