import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news.dart';

part 'state.dart';
part 'data_provider.dart';
part 'repository.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit() : super(const TopHeadlinesLoading());

  final repository = NewsRepository();

  Future<void> fetchNews() async {
    emit(const TopHeadlinesLoading());
    try {
      final data = await repository.fetchNews();

      emit(
        TopHeadlinesSuccess(data: data),
      );
    } catch (e) {
      emit(
        TopHeadlinesFailure(e.toString()),
      );
    }
  }
}
