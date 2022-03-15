import 'package:easy_localization/easy_localization.dart';

import '../../translation/generated/locale_keys.g.dart';

enum SupportedLanguage { fr, en }

extension SavedAddressExtension on SupportedLanguage {
  String get language {
    switch (this) {
      case SupportedLanguage.fr:
        return LocaleKeys.langage_french.tr();
      case SupportedLanguage.en:
        return LocaleKeys.langage_english.tr();
    }
  }
}
