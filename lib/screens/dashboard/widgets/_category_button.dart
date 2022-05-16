part of '../dashboard.dart';

class _CategoryCustomButton extends StatelessWidget {
  final int categoryIndex;
  final String categoryName;

  const _CategoryCustomButton({
    Key? key,
    required this.categoryIndex,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return InkWell(
      onTap: () {
        categoryProvider.categoryIndexUpdate = categoryIndex;
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: categoryProvider.categoryIndexGet == categoryIndex ? 1 : 0.5,
        child: Container(
          margin: Space.h,
          padding: Space.all(),
          decoration: BoxDecoration(
            color: categoryProvider.categoryIndexGet == categoryIndex
                ? AppTheme.c!.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              AppDimensions.normalize(2),
            ),
          ),
          child: Center(
            child: Text(
              toBeginningOfSentenceCase(
                categoryName,
              )!,
              style: AppText.b2b!.copyWith(
                color: categoryProvider.categoryIndexGet == categoryIndex
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
