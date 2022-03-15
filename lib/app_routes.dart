import 'global/constants/consts.dart';
import 'ui/news_feature/data/models/article_model.dart';
import 'ui/news_feature/view/article_detail/article_detail_page.dart';
import 'ui/news_feature/view/favorite_articles/favorite_articles_page.dart';
import 'ui/news_feature/view/main_page/main_page.dart';
import 'ui/news_feature/view/settings/setting_page.dart';
import 'package:flutter/material.dart';

//** controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case mainPage:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case favoriteArticlesPage:
      return MaterialPageRoute(
        builder: (context) => const FavoriteArticlePage(),
      );
    case articleDetailPage:
      return MaterialPageRoute(
        builder: (context) => ArticleDetailPage(
          articleModel: settings.arguments as ArticleModel,
        ),
      );
    case settingPage:
      return MaterialPageRoute(
        builder: (context) => SettingPage(),
      );
    default:
      throw ('this route name does not exist');
  }
}
