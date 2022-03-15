import 'dart:io';

import 'package:appsolute_news/core/errors/exceptions.dart';
import 'package:appsolute_news/core/network/dio_instance.dart';
import 'package:appsolute_news/global/constants/consts.dart';
import 'package:appsolute_news/global/constants/enums/news_api_domain.dart';
import 'package:appsolute_news/global/constants/enums/supported_language.dart';
import 'package:appsolute_news/ui/news_feature/data/datasources/news_remote_data_source.dart';
import 'package:appsolute_news/ui/news_feature/data/models/articles_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../test_const/consts.dart';

void main() {
  late NewsRemoteDataSourceImpl newsRemoteDataSource;
  late DioInstanceImpl mockDio;
  late Dio dioInstance;
  late DioAdapter dioAdapter;
  late ArticlesModel expectedNews;
  setUp(() {
    mockDio = DioInstanceImpl();
    dioInstance = mockDio.dioInstance;
    dioAdapter = DioAdapter(dio: dioInstance);
    newsRemoteDataSource = NewsRemoteDataSourceImpl(dio: dioInstance);
    expectedNews = ArticlesModel.fromMap(readArticlesFixture());
  });

  group('get news', () {
    test(
      'should preform a GET news',
      () async {
        //arrange
        dioAdapter.onGet(
          topHeadlinesEndPoint,
          (server) => server.reply(HttpStatus.ok, readArticlesFixture()),
        );
        // act
        final news = await newsRemoteDataSource.getAllNews(
            page: testPage,
            category: NewsApiCategory.business.name,
            language: SupportedLanguage.en.name,
            searchFor: '');
        // assert
        expect(news, equals(expectedNews));
      },
    );
    test(
      'should return empty article when result does not contain all required data: {"any":"any"}',
      () async {
        //arrange
        dioAdapter.onGet(
          topHeadlinesEndPoint,
          (server) => server.reply(HttpStatus.ok, {"any": "any"}),
        );
        // act
        final news = await newsRemoteDataSource.getAllNews(
            page: testPage,
            category: NewsApiCategory.business.name,
            language: SupportedLanguage.en.name,
            searchFor: '');
        // assert
        expect(news, equals(ArticlesModel.empty()));
      },
    );

    test(
      'should thow server exception when called with unauthorized tocken [HttpStatus.unauthorized] ',
      () async {
//arrange
        dioAdapter.onGet(
          topHeadlinesEndPoint,
          (server) => server.reply(HttpStatus.unauthorized, "any"),
        );
        // act
        final call = newsRemoteDataSource.getAllNews;
        //assert
        expect(
            () => call(
                page: testPage,
                category: NewsApiCategory.business.name,
                language: SupportedLanguage.en.name,
                searchFor: ''),
            throwsA(TypeMatcher<ServerException>()));
      },
    );

    test(
      'should thow upgrade to paid plan exception when called with developper accoutn [HttpStatus.upgradeRequired] ',
      () async {
//arrange
        dioAdapter.onGet(
          topHeadlinesEndPoint,
          (server) => server.reply(HttpStatus.upgradeRequired, "any"),
        );
        // act
        final call = newsRemoteDataSource.getAllNews;
        //assert
        expect(
            () => call(
                page: testPage,
                category: NewsApiCategory.business.name,
                language: SupportedLanguage.en.name,
                searchFor: ''),
            throwsA(TypeMatcher<UpgradeToPayedPlanException>()));
      },
    );
    test(
      'should throw DioError when called with valid status code but invalid map body',
      () async {
//arrange
        dioAdapter.onGet(
          topHeadlinesEndPoint,
          (server) => server.reply(HttpStatus.ok, {"any"}),
        );
        // act
        final call = newsRemoteDataSource.getAllNews;
        //assert
        expect(
            () => call(
                page: testPage,
                category: NewsApiCategory.business.name,
                language: SupportedLanguage.en.name,
                searchFor: ''),
            throwsA(TypeMatcher<DioError>()));
      },
    );

    test(
      'should throw ServerException when called with valid status code but invalid string body',
      () async {
//arrange
        dioAdapter.onGet(
          topHeadlinesEndPoint,
          (server) => server.reply(HttpStatus.ok, "any"),
        );
        // act
        final call = newsRemoteDataSource.getAllNews;
        //assert
        expect(
            () => call(
                page: testPage,
                category: NewsApiCategory.business.name,
                language: SupportedLanguage.en.name,
                searchFor: ''),
            throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
