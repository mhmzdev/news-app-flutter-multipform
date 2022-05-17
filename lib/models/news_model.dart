import 'dart:convert';

class News {
  final String id;
  final String name;
  final String description;
  News({
    required this.id,
    required this.name,
    required this.description,
  });

  News copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return News(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'News(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is News &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
