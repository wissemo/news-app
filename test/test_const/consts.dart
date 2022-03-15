import 'package:appsolute_news/ui/news_feature/data/models/article_model.dart';
import 'package:appsolute_news/ui/news_feature/data/models/source_model.dart';

const testPage = 1;
const totalResultTest = 130;

const ArticleModel validArticleModel = ArticleModel(
    source: SourceModel(
      id: 'TEST',
      name: 'test',
    ),
    author: 'author',
    title: 'title',
    description: 'description',
    url: 'https://url.com',
    urlToImage:
        'https://imageio.forbes.com/specials-images/imageserve/622c76350eeba0c86be6e781/0x0.jpg?format=jpg&width=1200&fit=bounds',
    publishedAt: '2022-03-07T08:30:14Z',
    content: 'content');

const ArticleModel validArticleModelWithInvalidNetworkImage = ArticleModel(
    source: SourceModel(
      id: 'TEST',
      name: 'test',
    ),
    author: 'author',
    title: 'title',
    description: 'description',
    url: 'https://url.com',
    urlToImage:
        'https:////imageio.forbes.com/specials-images/imageserve/622c76350eeba0c86be6e781/0x0.jpg?format=jpg&width=1200&fit=bounds',
    publishedAt: '2022-03-07T08:30:14Z',
    content: 'content');

const ArticleModel invalidArticleModel = ArticleModel(
    source: SourceModel(
      id: '',
      name: '',
    ),
    author: '',
    title: '',
    description: '',
    url: '',
    urlToImage: '',
    publishedAt: '',
    content: '');
