import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;

  AppLocalizations({this.locale});

  // Support Language
  static List<Locale> supportedLocales = [Locale('ar'), Locale('en')];

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStings;

  Future loadJsonLanguage() async {
    String jsonString = await rootBundle.loadString(
      'assets/translations/${locale!.languageCode}.json',
    );

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  String translate(String key) => _localizedStings[key] ?? '';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}