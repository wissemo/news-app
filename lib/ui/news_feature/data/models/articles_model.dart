import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'article_model.dart';

class ArticlesModel extends Equatable {
  final int totalResults;
  final List<ArticleModel> articles;
  const ArticlesModel({
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object> get props => [totalResults, articles];

  Map<String, dynamic> toMap() {
    return {
      'totalResults': totalResults,
      'articles': articles.map((x) => x.toMap()).toList(),
    };
  }

  factory ArticlesModel.fromMap(Map<String, dynamic> map) {
    return ArticlesModel(
      totalResults: map['totalResults']?.toInt() ?? 0,
      articles: (map['articles'] != null)
          ? List<ArticleModel>.from(
              map['articles']?.map((x) => ArticleModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticlesModel.empty() =>
      const ArticlesModel(totalResults: 0, articles: []);

  factory ArticlesModel.fromJson(String source) =>
      ArticlesModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ArticlesModel(totalResults: $totalResults, articles: $articles)';
}
