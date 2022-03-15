import '../../../../core/network/api_response.dart';
import '../../../../global/translation/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/article_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global/constants/assets_path.dart';
import '../../../../global/utils/functions.dart';
import '../../../../injection_container.dart';
import '../../view_model/favorite_news_view_model.dart';
import '../main_page/widgets/article_image_widget.dart';
import '../main_page/widgets/source_name_and_date_widget.dart';

class ArticleDetailPage extends StatefulWidget {
  final ArticleModel articleModel;
  const ArticleDetailPage({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<FavoriteNewsViewModel>(context, listen: false)
          .checkCachedNews(articleModel: widget.articleModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: InkWell(
                        onTap: () => launchURL(
                            context: context,
                            theme: theme,
                            url: widget.articleModel.url),
                        child: ArticleImageWidget(
                            articleModel: widget.articleModel),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: BackButton(
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.share,
                            color: theme.primaryColor,
                          ),
                          onPressed: () => Share.share(widget.articleModel.url,
                              subject: widget.articleModel.title),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => launchURL(
                          context: context,
                          theme: theme,
                          url: widget.articleModel.url,
                        ),
                        child: Text(
                          widget.articleModel.title,
                          style: theme.textTheme.headline1,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Consumer<FavoriteNewsViewModel>(
                        builder: (context, value, child) {
                      switch (value.apiResponse.status) {
                        case Status.initial:
                          return IconButton(
                            onPressed: () => value.addToFavorite(
                                articleModel: widget.articleModel),
                            icon: Icon(
                              Icons.star_outline,
                              color: Colors.amberAccent[400],
                            ),
                          );
                        case Status.completed:
                          return IconButton(
                            onPressed: () => value.removeFromFavorite(
                                articleModel: widget.articleModel),
                            icon: Icon(
                              Icons.star,
                              color: Colors.amberAccent[400],
                            ),
                          );
                        case Status.loading:
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                              height: 25,
                              width: 25,
                            ),
                          );
                        default:
                          return IconButton(
                            onPressed: () => value.addToFavorite(
                                articleModel: widget.articleModel),
                            icon: Icon(
                              Icons.star_outline,
                              color: theme.errorColor,
                            ),
                          );
                      }
                    })
                  ],
                ),
              ),
              SourceNameAndDateWidget(
                articleModel: widget.articleModel,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.articleModel.content,
                  style: theme.textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
