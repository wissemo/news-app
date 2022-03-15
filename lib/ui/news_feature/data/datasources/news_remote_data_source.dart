import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../global/constants/consts.dart';
import '../models/articles_model.dart';

abstract class NewsRemoteDataSource {
  Future<ArticlesModel> getAllNews(
      {required int page,
      required String category,
      required String language,
      required String searchFor});
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  final Dio dio;
  NewsRemoteDataSourceImpl({
    required this.dio,
  });
  @override
  Future<ArticlesModel> getAllNews(
      {required int page,
      required String category,
      required String language,
      required String searchFor}) async {
    final parameters = {
      'page': page,
      'category': category,
      'language': language,
      'q': searchFor,
    };
    final responce = await dio.get(
      topHeadlinesEndPoint,
      queryParameters: parameters,
    );
    if (responce.statusCode == HttpStatus.ok && responce.data is Map)
      return ArticlesModel.fromMap(responce.data);
    else if (responce.statusCode == HttpStatus.upgradeRequired)
      throw UpgradeToPayedPlanException();
    throw ServerException();
  }
}
