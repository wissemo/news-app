import 'ui/news_feature/view_model/favorite_news_view_model.dart';
import 'ui/news_feature/view_model/news_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart' as route;
import 'global/constants/assets_path.dart';
import 'global/constants/consts.dart';
import 'global/constants/enums/supported_language.dart';
import 'global/theme/themes.dart';
import 'global/translation/generated/codegen_loader.g.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        path: translationPath,
        supportedLocales: [
          Locale(SupportedLanguage.en.name),
          Locale(SupportedLanguage.fr.name),
        ],
        startLocale: Locale(SupportedLanguage.fr.name),
        assetLoader: const CodegenLoader(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => sl<NewsViewModel>(),
            ),
            ChangeNotifierProvider(
              create: (_) => sl<FavoriteNewsViewModel>(),
            ),
          ],
          child: const MyApp(),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        title: appName,
        theme: appTheme,
        onGenerateRoute: route.controller,
        initialRoute: mainPage);
  }
}
