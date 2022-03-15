import 'package:flutter/material.dart';

import '../../../../../global/constants/enums/supported_language.dart';

class CountryPickerItemWidget extends StatelessWidget {
  final SupportedLanguage supportedLanguage;

  const CountryPickerItemWidget({Key? key, required this.supportedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            supportedLanguage.language,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ],
    );
  }
}
