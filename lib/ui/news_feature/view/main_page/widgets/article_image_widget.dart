import 'package:flutter/material.dart';

import '../../../data/models/article_model.dart';

import '../../../../../global/constants/assets_path.dart';
import '../../../data/models/favorite_article_model.dart';

class ArticleImageWidget extends StatelessWidget {
  final ArticleModel articleModel;
  const ArticleImageWidget({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFavoriteArticleModel =
        articleModel.runtimeType == FavoriteArticleModel;
    final mediaQuery = MediaQuery.of(context);
    if (isFavoriteArticleModel)
      return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.file(
            (articleModel as FavoriteArticleModel).getLocalImage(),
            height: 200,
            width: mediaQuery.size.width,
            fit: BoxFit.fill,
            errorBuilder: (context, exception, stackTrace) {
              return Image.asset(
                noImage,
                height: 200,
                fit: BoxFit.fill,
              );
            },
          ));
    else
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          articleModel.validUrlToImage(),
          height: 200,
          width: mediaQuery.size.width,
          fit: BoxFit.fill,
          errorBuilder: (context, exception, stackTrace) {
            return Image.asset(
              noImage,
              height: 200,
              fit: BoxFit.fill,
            );
          },
        ),
      );
  }
}
