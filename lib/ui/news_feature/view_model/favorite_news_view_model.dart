import 'package:appsolute_news/global/translation/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/network/api_response.dart';
import '../../../global/utils/functions.dart';
import '../data/models/article_model.dart';
import '../data/models/favorite_article_model.dart';
import '../repository/news_repository.dart';

class FavoriteNewsViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial();
  final NewsRepository newsRepository;

  FavoriteNewsViewModel({
    required this.newsRepository,
  });

  List<FavoriteArticleModel> _favoriteArticles = [];
  ApiResponse get response {
    return _apiResponse;
  }

  List<FavoriteArticleModel> get favoriteArticles {
    return _favoriteArticles;
  }

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getCachedNews() async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    _favoriteArticles = await newsRepository.getCachedNews();
    _apiResponse = ApiResponse.completed(_favoriteArticles);
  }

  Future<void> addToFavorite({required ArticleModel articleModel}) async {
    _apiResponse = ApiResponse.loading();
    if (!articleModel.validateUrlToImage()) {
      _apiResponse = ApiResponse.error(LocaleKeys.errors_invalid_image.tr());
    } else {
      notifyListeners();
      final cachOrFailure =
          await newsRepository.cacheNews(articleModel: articleModel);
      cachOrFailure.fold(
        (failure) => _apiResponse =
            ApiResponse.error(mapFailureToMessage(failure: failure)),
        (cachedArticles) {
          _favoriteArticles = cachedArticles;
          _apiResponse = ApiResponse.completed(_favoriteArticles);
        },
      );
    }
    notifyListeners();
  }

  Future<void> removeFromFavorite({required ArticleModel articleModel}) async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    final list =
        await newsRepository.deleteCachedNews(articleModel: articleModel);
    _favoriteArticles = list;
    _apiResponse = ApiResponse.initial();
    notifyListeners();
  }

  Future<void> checkCachedNews({required ArticleModel articleModel}) async {
    _apiResponse = ApiResponse.loading();
    notifyListeners();
    final state =
        await newsRepository.checkCachedArticle(articleModel: articleModel);
    if (state)
      _apiResponse = ApiResponse.completed(_favoriteArticles);
    else
      _apiResponse = ApiResponse.initial();
    notifyListeners();
  }
}
