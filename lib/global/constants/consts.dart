const appName = 'Appsolute News';

//* for Network
const newsApiBaseUrl = 'https://newsapi.org';
const newsApiToken = String.fromEnvironment('newsApiToken');
const pageSize = 50; //* news api result per page
const topHeadlinesEndPoint = '/v2/top-headlines';

//* for sharedpreferences
const favoriteNewsSharedPreferencesKey = "favoriteNewsSharedPreferencesKey";

//* app pages
const String mainPage = '/';
const String articleDetailPage = 'articleDetail';
const String favoriteArticlesPage = 'favoriteArticles';
const String settingPage = 'settings';

//*others
const String newsApiDateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";
const String customDateFormate = 'd MMMM y';
