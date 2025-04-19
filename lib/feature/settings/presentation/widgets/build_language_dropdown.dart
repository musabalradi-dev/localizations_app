import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizations_app/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:localizations_app/feature/settings/presentation/widgets/get_language_name.dart';

Widget buildLanguageDropdown(BuildContext context, Locale currentLocale) {
  final currentLanguageCode = currentLocale.languageCode;

  return DropdownButtonFormField<String>(
    value: currentLanguageCode.isNotEmpty ? currentLanguageCode : 'en',
    items: ['en', 'ar'].map((languageCode) {
      return DropdownMenuItem<String>(
        value: languageCode,
        child: Text(getLanguageName(languageCode)),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        context.read<SettingsBloc>().add(ChangeLanguageEvent(value));
      }
    },
  );
}