// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "langage": {
    "english": "English",
    "french": "French"
  },
  "errors": {
    "server_failed": "An error has occurred with our server please try again later",
    "cash_failed": "An error has occurred locally, please clear the application data and try again",
    "no_connexion": "You are not connected to the internet, please check your connection and try again",
    "upgrade_to_paid_plan": "Please upgrade to a paid plan if you need more results",
    "unexpected": "Unexpected error occurred",
    "invalid_date": "Invalid date",
    "launch_url": "Failed to launch website link",
    "invalid_image": "Invalid image"
  },
  "main_page": {
    "all_news_loaded": "All News have been loaded",
    "title": "Home",
    "no_saved_articles": "No items found",
    "categories": {
      "business": "Business",
      "entertainment": "Entertainment",
      "general": "General",
      "health": "Health",
      "science": "Science",
      "sports": "Sport",
      "technology": "Technology"
    },
    "search_hint": "Search"
  },
  "favorite_articles": {
    "no_saved_articles": "No items found",
    "title": "Favorite articles"
  },
  "settings": {
    "title": "Settings",
    "cancel": "Cancel"
  }
};
static const Map<String,dynamic> fr = {
  "langage": {
    "english": "Anglais",
    "french": "Français"
  },
  "errors": {
    "server_failed": "Une erreur est survenue avec notre serveur veuillez réessayer ultérieurement",
    "cash_failed": "Une erreur est survenue localement, veuillez effacer les données de l’application et réessayer",
    "no_connexion": "Vous vous n'êtes pas connecté à internet, veuillez vérifier votre connexion et réessayer",
    "upgrade_to_paid_plan": "Veuillez passer à un plan payant si vous avez besoin de plus de résultats",
    "unexpected": "Une erreur inattendue s'est produite",
    "invalid_date": "Date invalide",
    "launch_url": "Échec du lancement du lien vers le site Web",
    "invalid_image": "Image invalide "
  },
  "main_page": {
    "all_news_loaded": "Toutes les nouvelles ont été chargées",
    "title": "Accueil",
    "no_saved_articles": "Aucun article trouvé ",
    "categories": {
      "business": "Entreprise",
      "entertainment": "Divertissement",
      "general": "Général",
      "health": "Santé",
      "science": "Science",
      "sports": "Sport",
      "technology": "Technologie"
    },
    "search_hint": "Rechercher"
  },
  "favorite_articles": {
    "no_saved_articles": "Aucun article trouvé ",
    "title": "Articles favoris"
  },
  "settings": {
    "title": "Réglages",
    "cancel": "Fermer"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fr": fr};
}
