import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../global/constants/enums/news_api_domain.dart';
import '../../../view_model/news_view_model.dart';

class CategoryItemWidget extends StatelessWidget {
  final NewsApiCategory newsApiCategory;
  const CategoryItemWidget({
    Key? key,
    required this.newsApiCategory,
  }) : super(key: key);

  void _changeNewsCategory(BuildContext context) {
    Provider.of<NewsViewModel>(context, listen: false).newsApiCategory !=
            newsApiCategory
        ? Provider.of<NewsViewModel>(context, listen: false)
            .changeNesApiCategory(
                newsApiCategory: newsApiCategory,
                language: context.locale.toString())
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      radius: 20.0,
      onTap: () => _changeNewsCategory(context),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        color: Provider.of<NewsViewModel>(context, listen: false)
                    .newsApiCategory ==
                newsApiCategory
            ? theme.primaryColor
            : theme.secondaryHeaderColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Text(
              newsApiCategory.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headline1?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
