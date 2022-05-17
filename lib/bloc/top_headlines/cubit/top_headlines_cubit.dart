import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/news_model.dart';

part 'top_headlines_state.dart';
part 'data_provider.dart';
part 'repository.dart';

class TopHeadlinesCubit extends Cubit<TopHeadlinesState> {
  TopHeadlinesCubit() : super(const TopHeadlinesLoading());

  final repository = NewsRepository();

  Future<void> fetchRepo() async {
    emit(
      const TopHeadlinesLoading(),
    );
    try {
      final data = await repository.fetchNews();
      emit(
        TopHeadlinesSuccess(data: data),
      );
    } catch (e) {
      emit(
        TopHeadlinesFailure(
          e.toString(),
        ),
      );
    }
  }
}
