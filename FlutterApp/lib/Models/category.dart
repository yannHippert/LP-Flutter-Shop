class Category {
  final int _id;
  final String _name;

  Category({required int id, required String name})
      : _id = id,
        _name = name;

  Category.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'];

  int get id => _id;

  String get name => _name;
}
