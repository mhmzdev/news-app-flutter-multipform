import 'package:flutter/material.dart';
import 'package:news_app/configs/configs.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Space.x1!,
            Text(
              "Top Stories",
              style: AppText.h2b!,
            ),
            Space.xf(11),
            const Icon(Icons.double_arrow),
          ],
        ),
        SizedBox(
          height: 200,
          width: 370,
          child: Card(
            color: AppTheme.c!.primary,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
