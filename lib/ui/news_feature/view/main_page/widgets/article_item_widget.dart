import 'package:flutter/material.dart';

import '../../../../../global/constants/consts.dart';
import '../../../data/models/article_model.dart';
import 'article_image_widget.dart';
import 'source_name_and_date_widget.dart';

class ArtileItemWidget extends StatelessWidget {
  final ArticleModel articleModel;
  const ArtileItemWidget({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        articleDetailPage,
        arguments: articleModel,
      ),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ArticleImageWidget(articleModel: articleModel),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  articleModel.title,
                  style: theme.textTheme.headline1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  articleModel.description,
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 7.0,
              ),
              child: SourceNameAndDateWidget(
                articleModel: articleModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
