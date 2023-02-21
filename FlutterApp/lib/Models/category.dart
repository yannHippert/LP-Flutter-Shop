class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
