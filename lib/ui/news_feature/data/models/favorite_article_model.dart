import 'dart:convert';
import 'dart:io';

import '../../../../global/utils/extensions.dart';
import 'article_model.dart';
import 'source_model.dart';

class FavoriteArticleModel extends ArticleModel {
  final String cachedImagePath;

  const FavoriteArticleModel({
    required source,
    required author,
    required title,
    required description,
    required url,
    required urlToImage,
    required publishedAt,
    required content,
    required this.cachedImagePath,
  }) : super(
          author: author,
          content: content,
          description: description,
          publishedAt: publishedAt,
          source: source,
          title: title,
          url: url,
          urlToImage: urlToImage,
        );

  @override
  List<Object> get props {
    return [
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'cachedImagePath': cachedImagePath
    };
  }

  factory FavoriteArticleModel.fromMap(Map<String, dynamic> map) {
    return FavoriteArticleModel(
        source: SourceModel.fromMap(map['source'] ?? {}),
        author: map['author'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        url: map['url'] ?? '',
        urlToImage: map['urlToImage'] ?? '',
        publishedAt: map['publishedAt'] ?? '',
        content: map['content'] ?? '',
        cachedImagePath: map['cachedImagePath']);
  }

  String toJson() => json.encode(toMap());

  factory FavoriteArticleModel.fromJson(String source) =>
      FavoriteArticleModel.fromMap(json.decode(source));

  factory FavoriteArticleModel.fromArticleModel({
    required ArticleModel articleModel,
    required String imageLocalPath,
  }) =>
      FavoriteArticleModel(
          cachedImagePath: imageLocalPath,
          author: articleModel.author,
          content: articleModel.content,
          description: articleModel.description,
          publishedAt: articleModel.publishedAt,
          source: articleModel.source,
          title: articleModel.title,
          url: articleModel.url,
          urlToImage: articleModel.urlToImage);

  @override
  String toString() {
    return 'ArticleModel(source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  bool validateUrl() => url.validateUrl();

  bool validateUrlToImage() => urlToImage.validateUrl();

  bool operator ==(articleModel) =>
      articleModel is ArticleModel &&
      articleModel.author == author &&
      articleModel.content == content &&
      articleModel.description == description &&
      articleModel.url == url &&
      articleModel.publishedAt == publishedAt &&
      articleModel.source == source &&
      articleModel.urlToImage == urlToImage;

  File getLocalImage() {
    final cachedImage = File(cachedImagePath);
    return cachedImage;
  }
}
