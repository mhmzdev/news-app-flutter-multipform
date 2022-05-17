part of 'top_headlines_cubit.dart';

class NewsDataProvider {
  static final dio = Dio();
  static Future<List<News>> fetchNews() async {
    try {
      final response = await dio.get(
          'https://newsapi.org/v2/top-headlines/sources?category=technology&apiKey=5027e68bc08f498ea15f480127f7b086');
      Map raw = response.data;
      List newsList = raw['sources']; 
      List<News> news = List.generate(
        newsList.length,
        (index) => News.fromMap(
          newsList[index],
        ),
      );

      return news;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
