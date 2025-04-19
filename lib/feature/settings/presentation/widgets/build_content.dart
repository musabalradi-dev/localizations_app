import 'package:flutter/material.dart';
import 'package:localizations_app/app/localizations/app_localizations.dart';
import 'package:localizations_app/feature/settings/presentation/widgets/build_language_dropdown.dart';

Widget buildContent(BuildContext context, Locale locale) {
  final localizations = AppLocalizations.of(context);
  final languageCode = locale.languageCode.isNotEmpty
      ? locale.languageCode
      : 'en';

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        buildLanguageDropdown(context, locale),
        const SizedBox(height: 20),
        Text(
          '${localizations?.translate('current_language') ??
              'Current Language'}: ${languageCode.toUpperCase()}',
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
      ],
    ),
  );
}