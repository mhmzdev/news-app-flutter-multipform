part of '../dashboard.dart';

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Space.v,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppDimensions.normalize(3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 8,
          )
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: AppUtils.categories
              .asMap()
              .entries
              .map(
                (e) => _CategoryCustomButton(
                  categoryIndex: e.key,
                  categoryName: e.value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
