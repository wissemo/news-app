import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/errors/failures.dart';
import '../translation/generated/locale_keys.g.dart';

String mapFailureToMessage({required Failure failure}) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return LocaleKeys.errors_server_failed.tr();
    case CacheFailure:
      return LocaleKeys.errors_cash_failed.tr();
    case ConnectionFailure:
      return LocaleKeys.errors_no_connexion.tr();
    case UpgradeToPayedPlanFailure:
      return LocaleKeys.errors_upgrade_to_paid_plan.tr();
    default:
      return LocaleKeys.errors_unexpected.tr();
  }
}

void launchURL(
    {required BuildContext context,
    required ThemeData theme,
    required String url}) async {
  try {
    if (!await launch(url))
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(LocaleKeys.errors_launch_url.tr()),
            backgroundColor: theme.errorColor),
      );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(LocaleKeys.errors_launch_url.tr()),
          backgroundColor: theme.errorColor),
    );
  }
}

void unfocusKeyBoard({required BuildContext context}) {
  final FocusScopeNode currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
