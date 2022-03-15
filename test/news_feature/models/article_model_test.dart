import 'dart:math';

import 'package:appsolute_news/global/constants/enums/supported_language.dart';
import 'package:appsolute_news/ui/news_feature/data/models/article_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../fixtures/fixture_reader.dart';
import '../../test_const/consts.dart';

void main() {
  test('validate uri to image that contain 4 slashes', () async {
    //assert
    expect(validArticleModelWithInvalidNetworkImage.validateUrl(), true);
    expect(validArticleModelWithInvalidNetworkImage.validateUrlToImage(), true);
    expect(validArticleModelWithInvalidNetworkImage.validUrlToImage(),
        'https://imageio.forbes.com/specials-images/imageserve/622c76350eeba0c86be6e781/0x0.jpg?format=jpg&width=1200&fit=bounds');
  });

  group('from json', () {
    test('should return a valid model with not null value', () async {
      //arrange
      final String json = readValidArticleFixture();
      //act
      final result = ArticleModel.fromJson(json);
      //assert
      expect(result, validArticleModel);
      expect(result.validateUrl(), true);
      expect(result.validUrlToImage(),
          'https://imageio.forbes.com/specials-images/imageserve/622c76350eeba0c86be6e781/0x0.jpg?format=jpg&width=1200&fit=bounds');
      expect(result.validateUrlToImage(), true);
    });

    test('should return a valid model with invalid json', () async {
      //arrange
      final String json = readInvalidArticleFixture();
      //act
      final result = ArticleModel.fromJson(json);
      //assert
      expect(result, invalidArticleModel);
      expect(result.validateUrl(), false);
      expect(result.validateUrlToImage(), false);
    });
  });

  group('test format date', () {
    test('test format date for frensh with valid date', () async {
      //arrange
      await initializeDateFormatting('en', null);
      final String json = readValidArticleFixture();
      final result = ArticleModel.fromJson(json);
      final expectedFrDate = '7 mars 2022';
      //act
      final date = result.getFormatedDate(locale: SupportedLanguage.fr.name);
      //assert
      expect(date, expectedFrDate);
    });

    test('test format date for english with valid date', () async {
      //arrange
      await initializeDateFormatting('en', null);
      final String json = readValidArticleFixture();
      final result = ArticleModel.fromJson(json);
      final expectedFrDate = '7 March 2022';
      //act
      final date = result.getFormatedDate(locale: SupportedLanguage.en.name);
      //assert
      expect(date, expectedFrDate);
    });

    test('test with invalid date and it should not throw exception', () async {
      //arrange
      await initializeDateFormatting('en', null);
      final String json = readInvalidArticleFixture();
      final result = ArticleModel.fromJson(json);
      //act
      final date = result.getFormatedDate(locale: SupportedLanguage.en.name);
      //assert
      expect(date.isNotEmpty, true);
    });
  });
}
