class Size {
  final int _id;
  final String _name;

  Size({required int id, required String name})
      : _id = id,
        _name = name;

  Size.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'];

  int get id => _id;

  String get name => _name;
}
