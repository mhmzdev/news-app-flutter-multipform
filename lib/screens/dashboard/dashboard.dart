import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/animations/bottom_animation.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/cubits/top_headlines/cubit.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/widgets/headlines_card.dart';
import 'package:news_app/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'widgets/_category_tabs.dart';
part 'widgets/_category_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    final newsCubit = BlocProvider.of<TopHeadlinesCubit>(context);
    if (newsCubit.state.data == null || newsCubit.state.data!.isEmpty) {
      newsCubit.fetchNews();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
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
                    child: CircleAvatar(
                      maxRadius: AppDimensions.normalize(20),
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
                    onPressed: () {},
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
                    return const LinearProgressIndicator();
                  } else if (state is TopHeadlinesFailure) {
                    return Text(state.error!);
                  } else if (state is TopHeadlinesSuccess) {
                    List<News> recentNews =
                        List.generate(3, (index) => state.data![index]);
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
            ],
          ),
        ),
      ),
    );
  }
}
