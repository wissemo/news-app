import 'package:flutter/material.dart';

import '../../../core/network/api_response.dart';
import '../../../global/constants/consts.dart';
import '../../../global/constants/enums/news_api_domain.dart';
import '../../../global/utils/functions.dart';
import '../data/models/article_model.dart';
import '../repository/news_repository.dart';

class NewsViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial();
  final NewsRepository newsRepository;

  NewsViewModel({
    required this.newsRepository,
  });

  List<ArticleModel> _articles = [];
  int _totalResults = 0;
  bool _reachedMaxPages = false;
  int _pagesCount = 0;
  NewsApiCategory _newsApiCategory = NewsApiCategory.general;
  String _searchFor = "";
  ApiResponse get response {
    return _apiResponse;
  }

  get rechedMaxPage => _reachedMaxPages;

  get pageCount => _pagesCount;

  get totalResult => _totalResults;

  get newsApiCategory => _newsApiCategory;

  get searchFor => _searchFor;

 List<ArticleModel> get articles {
    return _articles;
  }

  bool _checkMaxPageReached() => _totalResults <= _pagesCount * pageSize;

  void searchByKeywordOrPhrase({
    required String value,
    required String language,
  }) {
    _searchFor = value;
    fetchNews(language: language);
  }

  void clearByKeywordOrPhrase({
    required String language,
  }) {
    _searchFor = "";
    fetchNews(language: language);
  }


  void changeNesApiCategory(
      {required NewsApiCategory newsApiCategory, required String language}) {
    _newsApiCategory = newsApiCategory;
    fetchNews(language: language);
  }

  ApiResponse get apiResponse => _apiResponse;
  void _reset() {
    _articles = [];
    _pagesCount = 0;
    _reachedMaxPages = false;
  }

  Future<void> fetchMoreNews({required String language}) async {
    if (_checkMaxPageReached()) {
      _reachedMaxPages = true;
    } else {
      _apiResponse = ApiResponse.loading();
      notifyListeners();
      await _fetchMedia(language: language);
    }
    notifyListeners();
  }

  Future<void> fetchNews({required String language}) async {
    _apiResponse = ApiResponse.loading();
    _reset();
    notifyListeners();
    await _fetchMedia(language: language);
    notifyListeners();
  }

//**fetch articles
  Future<void> _fetchMedia({required String language}) async {
    final newsListOrFailure = await newsRepository.getNews(
        searchFor: _searchFor,
        page: ++_pagesCount,
        category: _newsApiCategory.name,
        language: language);
    newsListOrFailure.fold(
      (failure) => _apiResponse =
          ApiResponse.error(mapFailureToMessage(failure: failure)),
      (newArticles) {
        _articles.addAll(newArticles.articles);
        _totalResults = newArticles.totalResults;
        return _apiResponse = ApiResponse.completed(_articles);
      },
    );
  }
}
