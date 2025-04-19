import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizations_app/app/localizations/app_localizations.dart';
import 'package:localizations_app/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:localizations_app/feature/settings/presentation/widgets/build_content.dart';

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
            return buildContent(context, state.locale);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}