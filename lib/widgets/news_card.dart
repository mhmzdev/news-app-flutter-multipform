import 'package:flutter/material.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/models/news_model.dart';

class NewsCard extends StatelessWidget {
  final News? news;
  const NewsCard({Key? key, this.news,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dummy =
        'Dummy news headline is here with more than 100 words to end with ...';

    return Container(
      width: double.infinity,
      margin: Space.all(0, 0.5),
      padding: Space.all(0.5, 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppDimensions.normalize(3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 10),
            blurRadius: 12,
            spreadRadius: 6.0,
          )
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppDimensions.normalize(35),
                  height: AppDimensions.normalize(35),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      AppDimensions.normalize(3),
                    ),
                  ),
                ),
                Space.x1!,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news!.name,
                        style: AppText.h2b!.copyWith(
                          height: 1.1,
                        ),
                      ),
                      Space.y1!,
                      Text(
                        '18th-Jan-2022',
                        style: AppText.l1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Space.y1!,
            Text(
              news!.description,
              style: AppText.l1!.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}