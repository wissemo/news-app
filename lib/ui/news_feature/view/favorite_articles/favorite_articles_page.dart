import '../../../../global/translation/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/api_response.dart';
import '../../view_model/favorite_news_view_model.dart';
import '../main_page/widgets/article_item_widget.dart';

class FavoriteArticlePage extends StatefulWidget {
  const FavoriteArticlePage({Key? key}) : super(key: key);

  @override
  State<FavoriteArticlePage> createState() => _FavoriteArticlePageState();
}

class _FavoriteArticlePageState extends State<FavoriteArticlePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<FavoriteNewsViewModel>(context, listen: false)
          .getCachedNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.favorite_articles_title.tr(),
        ),
      ),
      body: Container(
        child: Consumer<FavoriteNewsViewModel>(
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value.apiResponse.status == Status.completed ||
                    value.apiResponse.status == Status.initial)
                  if (value.favoriteArticles.isNotEmpty)
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: value.favoriteArticles.length,
                          itemBuilder: (context, index) {
                            return ArtileItemWidget(
                              articleModel: value.favoriteArticles[index],
                            );
                          }),
                    )
                  else
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                              LocaleKeys.favorite_articles_no_saved_articles
                                  .tr(),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headline1),
                        ),
                      ),
                    )
                else if (value.apiResponse.status == Status.loading)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (value.apiResponse.status == Status.error)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          value.apiResponse.message,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline1?.copyWith(
                            color: theme.errorColor,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
