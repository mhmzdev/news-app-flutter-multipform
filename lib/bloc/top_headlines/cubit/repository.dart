part of 'top_headlines_cubit.dart';

class NewsRepository {
  Future<List<News>> fetchNews() => NewsDataProvider.fetchNews();
}
