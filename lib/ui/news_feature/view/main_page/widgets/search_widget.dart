import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../global/translation/generated/locale_keys.g.dart';
import '../../../../../global/utils/functions.dart';
import '../../../view_model/news_view_model.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchEditTextController;
  const SearchWidget({
    Key? key,
    required this.searchEditTextController,
  }) : super(key: key);

  void _clearSearch(BuildContext context) {
    if (searchEditTextController.text.isNotEmpty) {
      Provider.of<NewsViewModel>(context, listen: false).clearByKeywordOrPhrase(
        language: context.locale.languageCode,
      );
      searchEditTextController.clear();
      unfocusKeyBoard(context: context);
    }
  }

  void _searchNews(BuildContext context) {
    if (searchEditTextController.text.isNotEmpty) {
      Provider.of<NewsViewModel>(context, listen: false)
          .searchByKeywordOrPhrase(
        language: context.locale.languageCode,
        value: searchEditTextController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 4,
            child: TextField(
              style: theme.textTheme.bodyText1,
              decoration: InputDecoration(
                hintText: LocaleKeys.main_page_search_hint.tr(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      _searchNews(context);
                      unfocusKeyBoard(context: context);
                    },
                    icon: Icon(
                      Icons.search,
                      color: theme.secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
              onSubmitted: (value) => _searchNews(context),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: searchEditTextController,
              // onChanged: (value) => amountInput = value,
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () => _clearSearch(context),
                child: Icon(Icons.clear_rounded),
              ),
            ),
          )
        ],
      ),
    );
  }
}
