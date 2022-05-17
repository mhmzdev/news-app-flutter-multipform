import 'dart:convert';

class ArticleSource {
  final String? id;
  final String? name;
  ArticleSource({
    this.id,
    this.name,
  });

  ArticleSource copyWith({
    String? id,
    String? name,
  }) {
    return ArticleSource(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  ArticleSource merge(ArticleSource model) {
    return ArticleSource(
      id: model.id ?? id,
      name: model.name ?? name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ArticleSource.fromMap(Map<String, dynamic> map) {
    return ArticleSource(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleSource.fromJson(String source) =>
      ArticleSource.fromMap(json.decode(source));

  @override
  String toString() => 'ArticleSrouce(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleSource && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
