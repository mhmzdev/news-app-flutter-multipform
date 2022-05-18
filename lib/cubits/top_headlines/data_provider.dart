part of 'cubit.dart';

class NewsDataProvider {
  static final dio = Dio();
  static const apiKey = Constants.apiKey;

  static Future<List<News>> fetchNews() async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines/sources?category=technology',
        options: Options(
          headers: {
            'Authorization': apiKey,
          },
        ),
      );

      Map raw = response.data;

      List newsList = raw['sources'];

      List<News> news = List.generate(
        newsList.length,
        (index) => News.fromMap(
          newsList[index],
        ),
      );

      return news;
    } on DioError catch (e) {
      if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('Poor internet connection. Please try again!');
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception('Problem connecting to the server. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
