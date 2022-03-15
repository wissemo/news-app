import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/article_model.dart';

class SourceNameAndDateWidget extends StatelessWidget {
  final ArticleModel articleModel;
  const SourceNameAndDateWidget({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: Icon(
                    Icons.person,
                  ),
                ),
                Expanded(
                  child: Text(
                    articleModel.source.name,
                    maxLines: 1,
                    style: theme.textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 5.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                  ),
                ),
                Expanded(
                  child: Text(
                    articleModel.getFormatedDate(
                        locale: context.locale.toString()),
                    style: theme.textTheme.bodyText2,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
