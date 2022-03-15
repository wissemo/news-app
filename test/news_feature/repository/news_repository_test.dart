import 'package:appsolute_news/core/errors/exceptions.dart';
import 'package:appsolute_news/core/errors/failures.dart';
import 'package:appsolute_news/core/network/network_info.dart';
import 'package:appsolute_news/global/constants/enums/news_api_domain.dart';
import 'package:appsolute_news/global/constants/enums/supported_language.dart';
import 'package:appsolute_news/ui/news_feature/data/datasources/news_local_data_source.dart';
import 'package:appsolute_news/ui/news_feature/data/datasources/news_remote_data_source.dart';
import 'package:appsolute_news/ui/news_feature/data/models/articles_model.dart';
import 'package:appsolute_news/ui/news_feature/repository/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import '../../test_const/consts.dart';
import 'news_repository_test.mocks.dart';

@GenerateMocks([NewsRemoteDataSource])
@GenerateMocks([NewsLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  late NewsRepository newsRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockNewsRemoteDataSource mockArticlesRemoteDataSource;
  late MockNewsLocalDataSource mockArticlesLocalDataSource;
  late ArticlesModel expectedNews;

  setUp(() {
    mockArticlesRemoteDataSource = MockNewsRemoteDataSource();
    mockArticlesLocalDataSource = MockNewsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    newsRepository = NewsRepositoryImpl(
      allArticalRemoteDataSource: mockArticlesRemoteDataSource,
      newsLocalDataSource: mockArticlesLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
    expectedNews = ArticlesModel.fromMap(readArticlesFixture());
  });

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  runTestsOnline(() {
    test('should check if the device is online', () {
      //arrange
      when(mockArticlesRemoteDataSource.getAllNews(
              page: testPage,
              category: NewsApiCategory.business.name,
              language: SupportedLanguage.en.name,
              searchFor: ''))
          .thenAnswer((_) async => expectedNews);
      // act
      newsRepository.getNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: '');
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyNoMoreInteractions(mockNetworkInfo);
    });

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockArticlesRemoteDataSource.getAllNews(
              page: testPage,
              category: NewsApiCategory.business.name,
              language: SupportedLanguage.en.name,
              searchFor: ''))
          .thenAnswer((_) async => expectedNews);
      // act
      final result = await newsRepository.getNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: '');
      // assert
      expect(result, Right(expectedNews));
      // Verify that the method has been called on the remote data
      verify(mockArticlesRemoteDataSource.getAllNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: ''));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockArticlesRemoteDataSource);
    });

    test(
        'should return serverfailure when the call to remote data source failed',
        () async {
      //arrange
      when(mockArticlesRemoteDataSource.getAllNews(
              page: testPage,
              category: NewsApiCategory.business.name,
              language: SupportedLanguage.en.name,
              searchFor: ''))
          .thenThrow(ServerException());
      //act
      final result = await newsRepository.getNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: '');
      //assert
      verify(mockArticlesRemoteDataSource.getAllNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: ''));
      verifyNoMoreInteractions(mockArticlesRemoteDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
    test(
        'should return UpgradeToPayedPlanFailure when the call to remote data throws UpgradeToPayedPlanException',
        () async {
      //arrange
      when(mockArticlesRemoteDataSource.getAllNews(
              page: testPage,
              category: NewsApiCategory.business.name,
              language: SupportedLanguage.en.name,
              searchFor: ''))
          .thenThrow(UpgradeToPayedPlanException());
      //act
      final result = await newsRepository.getNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: '');
      //assert
      verify(mockArticlesRemoteDataSource.getAllNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: ''));
      verifyNoMoreInteractions(mockArticlesRemoteDataSource);
      expect(result, equals(Left(UpgradeToPayedPlanFailure())));
    });
  });

  runTestsOffline(() {
    test('should return Connexion failure', () async {
      //act
      final result = await newsRepository.getNews(
          page: testPage,
          category: NewsApiCategory.business.name,
          language: SupportedLanguage.en.name,
          searchFor: '');
      //assert
      verifyZeroInteractions(mockArticlesRemoteDataSource);
      expect(result, equals(Left(ConnectionFailure())));
    });
  });
}
