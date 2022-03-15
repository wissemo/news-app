import '../../translation/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

enum NewsApiCategory {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology,
}

extension newsApiCategoryExtension on NewsApiCategory {
  //*get catgory with translation
  String get title {
    switch (this) {
      case NewsApiCategory.business:
        return LocaleKeys.main_page_categories_business.tr();
      case NewsApiCategory.entertainment:
        return LocaleKeys.main_page_categories_entertainment.tr();
      case NewsApiCategory.general:
        return LocaleKeys.main_page_categories_general.tr();
      case NewsApiCategory.health:
        return LocaleKeys.main_page_categories_health.tr();
      case NewsApiCategory.science:
        return LocaleKeys.main_page_categories_science.tr();
      case NewsApiCategory.sports:
        return LocaleKeys.main_page_categories_sports.tr();
      case NewsApiCategory.technology:
        return LocaleKeys.main_page_categories_technology.tr();
    }
  }
}
