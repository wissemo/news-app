import 'dart:convert';

import 'package:appsolute_news/ui/news_feature/data/models/source_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const SourceModel sourceModel = SourceModel(id: 'TEST', name: 'test');
  const SourceModel emptySourceModel = SourceModel(id: '', name: '');

  setUp(() {
    // sourceModel = SourceModel.fromJson(readSourceFixture());
  });

  group('from json', () {
    test('should return a valid model with not null value', () async {
      //arrange
      final String json = readValidSourceFixture();
      //act
      final result = SourceModel.fromJson(json);
      //assert
      expect(result, sourceModel);
    });
    test('should return a valid model with invalid json', () async {
      //arrange
      final String json = readInValidSourceFixture();
      //act
      final result = SourceModel.fromJson(json);
      //assert
      expect(result, emptySourceModel);
    });
  });
}
