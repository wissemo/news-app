import 'dart:io';

import '../../../../../global/constants/enums/supported_language.dart';
import 'country_picker_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../global/translation/generated/locale_keys.g.dart';

class CountryPickerWidget extends StatefulWidget {
  @override
  _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  late FixedExtentScrollController _scrollController;

  SupportedLanguage _getCurrentLanguage() {
    if (context.locale.toString() == SupportedLanguage.fr.name) {
      return SupportedLanguage.fr;
    }
    return SupportedLanguage.en;
  }

  Widget _buildItemPicker() {
    return SizedBox(
      height: 180,
      child: CupertinoPicker(
          itemExtent: 50.0,
          scrollController: FixedExtentScrollController(
            initialItem: SupportedLanguage.values.indexOf(
              _getCurrentLanguage(),
            ),
          ),
          onSelectedItemChanged: (index) {
            context.setLocale(
              Locale(
                SupportedLanguage.values[index].name,
              ),
            );
          },
          children: [
            ...SupportedLanguage.values.map<Widget>(
              (SupportedLanguage values) {
                return CountryPickerItemWidget(supportedLanguage: values);
              },
            ).toList(),
          ]),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController = FixedExtentScrollController(
          initialItem: SupportedLanguage.values.indexOf(_getCurrentLanguage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [_buildItemPicker()],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          LocaleKeys.settings_cancel.tr(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  );
                },
                child: CountryPickerItemWidget(
                  supportedLanguage: _getCurrentLanguage(),
                ),
              ),
              //color: CupertinoColors.activeBlue,
              borderRadius: BorderRadius.circular(15.0),
              elevation: 5,
            ),
          )
        : Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
            child: Material(
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<SupportedLanguage>(
                    items: SupportedLanguage.values
                        .map<DropdownMenuItem<SupportedLanguage>>(
                            (SupportedLanguage value) {
                      return DropdownMenuItem<SupportedLanguage>(
                        value: value,
                        onTap: () =>
                            context.setLocale(Locale(describeEnum(value))),
                        child:
                            CountryPickerItemWidget(supportedLanguage: value),
                      );
                    }).toList(),
                    onChanged: (supportedLanguage) {},
                    value: _getCurrentLanguage(),
                    isExpanded: true,
                  ),
                ),
              ),
              borderRadius: BorderRadius.circular(15.0),
              elevation: 5,
            ),
          );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
