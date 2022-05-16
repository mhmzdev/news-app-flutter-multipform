import 'package:flutter/material.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/utils/app_utils.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:provider/provider.dart';

part 'widgets/_category_tabs.dart';
part 'widgets/_category_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
                          'Monday, 17 May',
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
              const NewsCard(),
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
