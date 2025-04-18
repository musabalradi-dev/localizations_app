import 'package:flutter/material.dart';
import 'package:localizations_app/app/localizations/app_localizations.dart';

class SafeLocalizations {
  static String tr(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context);
    return localizations?.translate(key) ?? key;
  }
}