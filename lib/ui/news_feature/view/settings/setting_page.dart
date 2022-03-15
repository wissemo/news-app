import '../../../../global/translation/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/country_picker_widget.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_title.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CountryPickerWidget(),
      ),
    );
  }
}
