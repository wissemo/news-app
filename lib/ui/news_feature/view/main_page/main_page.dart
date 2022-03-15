import 'dart:async';

import '../../../../global/constants/enums/news_api_domain.dart';
import 'widgets/category_item_widget.dart';
import 'widgets/search_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/api_response.dart';
import '../../../../global/constants/consts.dart';
import '../../../../global/translation/generated/locale_keys.g.dart';
import '../../view_model/news_view_model.dart';
import 'widgets/article_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _searchEditTextController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _searchEditTextController = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<NewsViewModel>(context, listen: false)
          .fetchNews(language: context.locale.toString());
    });
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (Provider.of<NewsViewModel>(context, listen: false).articles.isEmpty &&
          result != ConnectivityResult.none) {
        Provider.of<NewsViewModel>(context, listen: false)
            .fetchNews(language: context.locale.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    _searchEditTextController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.main_page_title.tr(),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(favoriteArticlesPage),
            icon: Icon(
              Icons.star,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(settingPage),
            icon: Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Container(
        child: Consumer<NewsViewModel>(
          builder: (context, value, child) {
            return RefreshIndicator(
              onRefresh: () =>
                  Provider.of<NewsViewModel>(context, listen: false)
                      .fetchNews(language: context.locale.toString()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...NewsApiCategory.values.map<Widget>(
                          (NewsApiCategory values) {
                            return CategoryItemWidget(
                              newsApiCategory: values,
                            );
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                  SearchWidget(
                    searchEditTextController: _searchEditTextController,
                  ),
                  if (value.articles.isNotEmpty)
                    Expanded(
                      flex: 8,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: _handelScrollNotification,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: value.articles.length,
                            itemBuilder: (context, index) {
                              return ArtileItemWidget(
                                articleModel: value.articles[index],
                              );
                            }),
                      ),
                    ),
                  if (value.apiResponse.status == Status.loading)
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (value.apiResponse.status == Status.completed &&
                      value.rechedMaxPage)
                    Expanded(
                      child: Center(
                        child: Text(LocaleKeys.main_page_all_news_loaded.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headline1),
                      ),
                    ),
                  if (value.apiResponse.status == Status.completed &&
                      value.totalResult == 0)
                    Expanded(
                      child: Center(
                        child: Text(LocaleKeys.main_page_no_saved_articles.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headline1),
                      ),
                    ),
                  if (value.apiResponse.status == Status.error)
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            value.apiResponse.message,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headline1?.copyWith(
                              color: theme.errorColor,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _handelScrollNotification(ScrollNotification notification) {
    final NewsViewModel articlesViewModel =
        Provider.of<NewsViewModel>(context, listen: false);
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        articlesViewModel.apiResponse.status != Status.loading) {
      articlesViewModel.fetchMoreNews(language: context.locale.toString());
    }
    return false;
  }
}
