part of 'cubit.dart';

class NewsRepository {
  Future<List<News>> fetchNews() => NewsDataProvider.fetchNews();
}
