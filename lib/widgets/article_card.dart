import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:news_app/configs/configs.dart';
import 'package:news_app/models/article/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    required this.article,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: Space.all(0, 0.5),
      padding: Space.all(0.5, 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.normalize(3)),
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
        onTap: () => launchUrl(
          Uri.parse(article.url!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: AppDimensions.normalize(45),
                  height: AppDimensions.normalize(45),
                  decoration: BoxDecoration(
                    image: article.urlToImage != null
                        ? DecorationImage(
                            image: NetworkImage(article.urlToImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      AppDimensions.normalize(3),
                    ),
                  ),
                ),
                Space.y!,
                Text(
                  DateFormat('EE d, yyyy').format(
                    DateTime.parse(
                      article.publishedAt!,
                    ),
                  ),
                  style: AppText.b2,
                )
              ],
            ),
            Space.x1!,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    style: AppText.h3b!,
                    maxLines: 2,
                  ),
                  Space.y!,
                  Text(
                    article.source!.name!,
                    style: AppText.b2b,
                  ),
                  Space.y!,
                  Text(
                    article.description!,
                    maxLines: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
