part of 'cubit.dart';

class ArticlesDataProvider {
  static Future<Article> fetch() async {
    try {
      final Map<String, dynamic> raw = {"key": "value"};
      return Article.fromMap(raw);
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
