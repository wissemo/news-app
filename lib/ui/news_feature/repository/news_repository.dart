import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../data/datasources/news_local_data_source.dart';
import '../data/datasources/news_remote_data_source.dart';
import '../data/models/article_model.dart';
import '../data/models/articles_model.dart';
import '../data/models/favorite_article_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, ArticlesModel>> getNews(
      {required int page,
      required String category,
      required String language,
      required String searchFor});

  Future<Either<Failure, List<FavoriteArticleModel>>> cacheNews({
    required ArticleModel articleModel,
  });

  Future<List<FavoriteArticleModel>> getCachedNews();

  Future<List<FavoriteArticleModel>> deleteCachedNews(
      {required ArticleModel articleModel});

  Future<bool> checkCachedArticle({required ArticleModel articleModel});
}

class NewsRepositoryImpl extends NewsRepository {
  final NetworkInfo networkInfo;
  final NewsRemoteDataSource allArticalRemoteDataSource;
  final NewsLocalDataSource newsLocalDataSource;
  NewsRepositoryImpl({
    required this.networkInfo,
    required this.allArticalRemoteDataSource,
    required this.newsLocalDataSource,
  });
  @override
  Future<Either<Failure, ArticlesModel>> getNews(
      {required int page,
      required String category,
      required String searchFor,
      required String language}) async {
    if (await networkInfo.isConnected) {
      try {
        final articles = await allArticalRemoteDataSource.getAllNews(
            searchFor: searchFor,
            page: page,
            category: category,
            language: language);
        return Right(articles);
      } on ServerException {
        return Left(ServerFailure());
      } on DioError catch (e) {
        print(e);
        return Left(ServerFailure());
      } on UpgradeToPayedPlanException {
        return Left(UpgradeToPayedPlanFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavoriteArticleModel>>> cacheNews(
      {required ArticleModel articleModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final cache = await newsLocalDataSource.cacheNews(
          articleModel,
        );
        return Right(cache);
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<List<FavoriteArticleModel>> deleteCachedNews({
    required ArticleModel articleModel,
  }) async {
    return await newsLocalDataSource.deleteNews(articleModel: articleModel);
  }

  @override
  Future<List<FavoriteArticleModel>> getCachedNews() async {
    return await newsLocalDataSource.getAllCachedNews();
  }

  @override
  Future<bool> checkCachedArticle({required ArticleModel articleModel}) async {
    return await newsLocalDataSource.checkCachedArticle(articleModel);
  }
}
