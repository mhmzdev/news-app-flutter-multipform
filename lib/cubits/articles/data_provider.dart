part of 'cubit.dart';

class ArticlesDataProvider {
  static final dio = Dio();
  static const apiKey = Constants.apiKey;

  static Future<List<Article>> fetch({String? keyword}) async {
    try {
      keyword ?? 'latest';

      final response = await dio.get(
        'https://newsapi.org/v2/everything/q=$keyword',
        options: Options(
          headers: {
            'Authorization': apiKey,
          },
        ),
      );

      Map raw = response.data;
      List articlesList = raw['articles'];

      List<Article> articles = List.generate(
        articlesList.length,
        (index) => Article.fromMap(
          articlesList[index],
        ),
      );

      return articles;
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
      throw Exception("Internal Server Error");
    }
  }
}
