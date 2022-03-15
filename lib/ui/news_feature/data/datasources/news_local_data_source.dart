import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../global/constants/consts.dart';
import '../models/favorite_article_model.dart';

abstract class NewsLocalDataSource {
  Future<List<FavoriteArticleModel>> getAllCachedNews();

  Future<List<FavoriteArticleModel>> cacheNews(ArticleModel articleModel);

  Future<List<FavoriteArticleModel>> deleteNews(
      {required ArticleModel articleModel});

  Future<void> deleteAllNews();
  Future<bool> checkCachedArticle(ArticleModel articleModel);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final SharedPreferences sharedPreferences;
  final DefaultCacheManager defaultCacheManager;
  NewsLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.defaultCacheManager,
  });
  @override
  Future<List<FavoriteArticleModel>> cacheNews(
      ArticleModel articleModel) async {
    final cachedImage =
        await defaultCacheManager.downloadFile(articleModel.urlToImage);
    if (await cachedImage.file.exists()) {
      final FavoriteArticleModel favoriteArticleModel =
          FavoriteArticleModel.fromArticleModel(
              articleModel: articleModel,
              imageLocalPath: cachedImage.file.path);
      List<FavoriteArticleModel> allNews = await getAllCachedNews();
      await _cacheNewsList([favoriteArticleModel, ...allNews]);
      return [favoriteArticleModel, ...allNews];
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllNews() async {
    sharedPreferences.clear();
    defaultCacheManager.emptyCache();
  }

  @override
  Future<List<FavoriteArticleModel>> deleteNews(
      {required ArticleModel articleModel}) async {
    final cachedNews = await getAllCachedNews();
    defaultCacheManager.removeFile(articleModel.urlToImage);
    cachedNews.removeWhere((item) => item == articleModel);
    await _cacheNewsList(cachedNews);
    return cachedNews;
  }

  @override
  Future<List<FavoriteArticleModel>> getAllCachedNews() {
    final jsonString =
        sharedPreferences.getStringList(favoriteNewsSharedPreferencesKey);
    return (jsonString != null)
        ? Future.value(jsonString
            .map((news) => FavoriteArticleModel.fromJson(news))
            .toList())
        : Future.value(List.empty());
  }

  Future<void> _cacheNewsList(
      List<FavoriteArticleModel> favoriteArticleModel) async {
    List<String> jsonNewsList = favoriteArticleModel
        .map((favoriteNews) => favoriteNews.toJson())
        .toList();
    final result = await sharedPreferences.setStringList(
        favoriteNewsSharedPreferencesKey, jsonNewsList);
    if (!result) throw CacheException();
  }

  @override
  Future<bool> checkCachedArticle(ArticleModel articleModel) async {
    final cachedNews = await getAllCachedNews();
    return cachedNews.any((item) {
      return item == articleModel;
    });
  }
}
