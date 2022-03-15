import 'package:appsolute_news/ui/news_feature/data/models/article_model.dart';
import 'package:appsolute_news/ui/news_feature/data/models/articles_model.dart';
import 'package:appsolute_news/ui/news_feature/data/models/source_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('from json', () {
    test('should return a valid model with not null value', () async {
      //arrange
      final json = readArticlesFixture();
      //act
      final result = ArticlesModel.fromMap(json);
      //assert
      expect(result, isA<ArticlesModel>());
      expect(result.articles.isNotEmpty, true);
      expect(result.articles[0], isA<ArticleModel>());
      expect(result.articles[0].source, isA<SourceModel>());
    });
  });
}
