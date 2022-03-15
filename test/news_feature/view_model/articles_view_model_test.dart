import 'package:appsolute_news/core/errors/failures.dart';
import 'package:appsolute_news/core/network/api_response.dart';
import 'package:appsolute_news/global/constants/enums/news_api_domain.dart';
import 'package:appsolute_news/global/constants/enums/supported_language.dart';
import 'package:appsolute_news/ui/news_feature/data/models/articles_model.dart';
import 'package:appsolute_news/ui/news_feature/repository/news_repository.dart';
import 'package:appsolute_news/ui/news_feature/view_model/news_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import '../../test_const/consts.dart';
import 'articles_view_model_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late MockNewsRepository mockNewsRepository;
  late NewsViewModel newsViewModel;
  late ArticlesModel expectedNews;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    newsViewModel = NewsViewModel(newsRepository: mockNewsRepository);
    expectedNews = ArticlesModel.fromMap(readArticlesFixture());
  });

  test('verify stating values', () async {
    //assert
    expect(newsViewModel.articles, []);
    expect(newsViewModel.pageCount, 0);
    expect(newsViewModel.searchFor, "");
    expect(newsViewModel.apiResponse.status, Status.initial);
    expect(newsViewModel.rechedMaxPage, false);
    expect(newsViewModel.totalResult, 0);
    expect(newsViewModel.newsApiCategory, NewsApiCategory.general);
  });

  group('get news data', () {
    test('should return remote News data', () async {
      //arrange
      when(mockNewsRepository.getNews(
        page: 1,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      )).thenAnswer((_) async => Right(expectedNews));
      // act
      await newsViewModel.fetchNews(
        language: SupportedLanguage.fr.name,
      );
      // assert
      expect(newsViewModel.articles, equals(expectedNews.articles));
      expect(newsViewModel.apiResponse.status, Status.completed);
      expect(newsViewModel.pageCount, 1);
      expect(newsViewModel.totalResult, totalResultTest);
      // Verify that the method has been called on the repository
      verify(mockNewsRepository.getNews(
        page: newsViewModel.pageCount,
        category: NewsApiCategory.general.name,
        searchFor: newsViewModel.searchFor,
        language: SupportedLanguage.fr.name,
      ));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNewsRepository);
    });

    test('reatch max pages :all pages are loaded', () async {
      //arrange
      when(mockNewsRepository.getNews(
        page: 1,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      )).thenAnswer((_) async => Right(expectedNews));
      when(mockNewsRepository.getNews(
        page: 2,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      )).thenAnswer((_) async => Right(expectedNews));
      when(mockNewsRepository.getNews(
        page: 3,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      )).thenAnswer((_) async => Right(expectedNews));
      // act
      await newsViewModel.fetchNews(language: SupportedLanguage.fr.name);
      while (!newsViewModel.rechedMaxPage) {
        await newsViewModel.fetchMoreNews(language: SupportedLanguage.fr.name);
      }
      // assert
      expect(newsViewModel.rechedMaxPage, true);
      expect(newsViewModel.totalResult, totalResultTest);
      expect(newsViewModel.apiResponse.status, Status.completed);
      verify(mockNewsRepository.getNews(
        page: 1,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      ));
      verify(mockNewsRepository.getNews(
        page: 2,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      ));
      verify(mockNewsRepository.getNews(
        page: 3,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      ));
      verifyNever(mockNewsRepository.getNews(
        page: 4,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      ));
      verifyNoMoreInteractions(mockNewsRepository);
    });
  });

  group('should return failures', () {
    test('test when call return any failure', () async {
      //arrange
      when(mockNewsRepository.getNews(
        page: 1,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      )).thenAnswer(
        (_) async => Left(
          ConnectionFailure(),
        ),
      );
      // act
      await newsViewModel.fetchNews(language: SupportedLanguage.fr.name);
      // assert
      expect(newsViewModel.apiResponse.status, Status.error);
      expect(newsViewModel.apiResponse.message.isEmpty, false);
      verify(mockNewsRepository.getNews(
        page: 1,
        category: NewsApiCategory.general.name,
        searchFor: '',
        language: SupportedLanguage.fr.name,
      )).called(1);
      verifyNoMoreInteractions(mockNewsRepository);
    });
  });
}
