part of 'cubit.dart';

class ArticlesRepository {
  Future< Article> fetch() => ArticlesDataProvider.fetch();
}
