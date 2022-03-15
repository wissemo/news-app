import 'dart:convert';
import 'dart:io';

Map<String, dynamic> readArticlesFixture() =>
    jsonDecode(File('test/fixtures/articles.json').readAsStringSync());

String readValidArticleFixture() =>
    File('test/fixtures/article.json').readAsStringSync();

String readInvalidArticleFixture() =>
    File('test/fixtures/invalid_article.json').readAsStringSync();

String readValidSourceFixture() =>
    File('test/fixtures/source.json').readAsStringSync();

String readInValidSourceFixture() =>
    File('test/fixtures/invalid_source.json').readAsStringSync();
