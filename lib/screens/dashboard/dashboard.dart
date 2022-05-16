import 'package:flutter/material.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/screens/dashboard/widgets/news_card.dart';
import 'package:news_app/utils/app_utils.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        title: Text(
          'Newsy',
          style: AppText.h2b,
        ),
        actions: [
          const CircleAvatar(),
          Space.x!,
        ],
      ),
      body: Column(
        children: [
          Space.y1!,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: AppUtils.categories
                  .map(
                    (e) => ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: Space.all(1, 1),
                        child: Text(
                          toBeginningOfSentenceCase(e)!,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Space.y1!,
          const NewsCard()
        ],
      ),
    );
  }
}
