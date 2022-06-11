import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/animations/bottom_animation.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/cubits/articles/cubit.dart';
import 'package:news_app/cubits/top_headlines/cubit.dart';
import 'package:news_app/models/article/article.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:news_app/widgets/headlines_card.dart';
import 'package:news_app/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/_category_tabs.dart';
part 'widgets/_category_button.dart';
part 'widgets/_shimmer_article_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    final newsCubit = BlocProvider.of<TopHeadlinesCubit>(context);
    final articleCubit = BlocProvider.of<ArticlesCubit>(context);

    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    if (newsCubit.state.data == null || newsCubit.state.data!.isEmpty) {
      newsCubit.fetch(
        AppUtils.categories[categoryProvider.categoryIndexGet],
      );
    }
    if (articleCubit.state.data == null || articleCubit.state.data!.isEmpty) {
      articleCubit.fetch(keyword: 'latest');
    }
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final articleCubit = ArticlesCubit.cubit(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: Space.h1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Space.y1!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your breifing',
                            style: AppText.h1b!.copyWith(
                              fontSize: AppDimensions.normalize(13),
                              height: 1.1,
                            ),
                          ),
                          Space.y!,
                          Text(
                            DateFormat('EEEE, dd MMM').format(DateTime.now()),
                            style: AppText.l1!.copyWith(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Space.xm!,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          themeProvider.theme = !themeProvider.theme;
                        },
                        child: Container(
                          height: AppDimensions.normalize(30),
                          width: AppDimensions.normalize(30),
                          decoration: BoxDecoration(
                            color: themeProvider.isDark
                                ? Colors.grey[800]
                                : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.brightness_6_outlined,
                            color: themeProvider.isDark
                                ? Colors.yellow
                                : Colors.grey,
                            size: AppDimensions.normalize(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Space.y1!,
                const _CategoryTabs(),
                Space.y1!,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Stories',
                      style: AppText.h3b,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, '/top-stories',
                          arguments: {
                            'title': AppUtils.categories[context
                                .read<CategoryProvider>()
                                .categoryIndexGet],
                          }),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: AppDimensions.normalize(7),
                      ),
                    )
                  ],
                ),
                BlocBuilder<TopHeadlinesCubit, TopHeadlinesState>(
                  builder: (context, state) {
                    if (state is TopHeadlinesLoading) {
                      return Column(
                        children: [
                          const LinearProgressIndicator(),
                          for (int i = 0; i < 3; i++)
                            const _ShimmerArticleCard(
                              isArticle: false,
                            )
                        ],
                      );
                    } else if (state is TopHeadlinesFailure) {
                      return Text(state.error!);
                    } else if (state is TopHeadlinesSuccess) {
                      List<News> recentNews = List.generate(
                          state.data!.length >= 3 ? 3 : state.data!.length,
                          (index) => state.data![index]!);

                      return Column(
                        children: recentNews
                            .map(
                              (news) => BottomAnimator(
                                child: HeadlinesCard(
                                  news: news,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Text('Something Went Wrong!');
                    }
                  },
                ),
                Space.y2!,
                Text(
                  'Picks for you',
                  style: AppText.h3b,
                ),
                Space.y!,
                CustomTextField(
                  controller: searchController,
                  hint: 'Search keyword...',
                  textInputType: TextInputType.text,
                  prefixIcon: IconButton(
                    splashRadius: AppDimensions.normalize(8),
                    onPressed: () {
                      if (searchController.text.isNotEmpty) {
                        articleCubit.fetch(
                          keyword: searchController.text.trim(),
                        );
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                  onChangeFtn: (value) {
                    if (value == null || value.isEmpty) {
                      articleCubit.fetch();
                    }
                    return value;
                  },
                  isSuffixIcon: true,
                ),
                Space.y1!,
                BlocBuilder<ArticlesCubit, ArticlesState>(
                  builder: (context, state) {
                    if (state is ArticlesFetchLoading) {
                      return Column(
                        children: [
                          const LinearProgressIndicator(),
                          for (int i = 0; i < 3; i++)
                            const _ShimmerArticleCard(
                              isArticle: true,
                            ),
                        ],
                      );
                    } else if (state is ArticlesFetchFailed) {
                      return Text(state.message!);
                    } else if (state is ArticlesFetchSuccess) {
                      List<Article> recentNews = List.generate(
                          state.data!.length, (index) => state.data![index]);
                      return Column(
                        children: recentNews
                            .map(
                              (article) => BottomAnimator(
                                child: ArticleCard(
                                  article: article,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: Text('Something Went Wrong!'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
