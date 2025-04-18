import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizations_app/app/localizations/app_localizations.dart';
import 'package:localizations_app/feature/settings/presentation/bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام SafeLocalizations للتحقق من null
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.translate('settings') ?? 'Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is LanguageChangedState) {
            return _buildContent(context, state.locale);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Locale locale) {
    final localizations = AppLocalizations.of(context);
    final languageCode = locale.languageCode.isNotEmpty
        ? locale.languageCode
        : 'en';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildLanguageDropdown(context, locale),
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

  Widget _buildLanguageDropdown(BuildContext context, Locale currentLocale) {
    final currentLanguageCode = currentLocale.languageCode;

    return DropdownButtonFormField<String>(
      value: currentLanguageCode.isNotEmpty ? currentLanguageCode : 'en',
      items: ['en', 'ar'].map((languageCode) {
        return DropdownMenuItem<String>(
          value: languageCode,
          child: Text(_getLanguageName(languageCode)),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          context.read<SettingsBloc>().add(ChangeLanguageEvent(value));
        }
      },
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English 🇬🇧';
      case 'ar':
        return 'العربية 🇸🇦';
      default:
        return 'English 🇬🇧';
    }
  }
}