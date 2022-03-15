import 'dart:convert';

import '../../../../global/translation/generated/locale_keys.g.dart';
import '../../../../global/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../../../../global/constants/consts.dart';
import 'source_model.dart';

class ArticleModel extends Equatable {
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

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
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      source: SourceModel.fromMap(map['source'] ?? {}),
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArticleModel(source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  //* there is images that start with https://// we need to change it to https://
  String validUrlToImage() => urlToImage.replaceAll('////', '//');

  bool validateUrl() => url.validateUrl();

  bool validateUrlToImage() => urlToImage.validateUrl();

  String getFormatedDate({required String locale}) {
    try {
      final DateTime parseDate =
          new DateFormat(newsApiDateFormat).parse(publishedAt);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(customDateFormate, locale);
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } on FormatException {
      return LocaleKeys.errors_invalid_date.tr();
    }
  }
}
