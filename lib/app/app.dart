import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizations_app/app/localizations/app_localizations.dart';
import 'package:localizations_app/app/localizations/app_localizations_delegate.dart';
import 'package:localizations_app/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:localizations_app/feature/settings/presentation/screen/settings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc()..add(const GetSavedLanguageEvent()),
        ),
      ],
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is LanguageChangedState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: state.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizationDelegates.localizationsDelegates,
                localeResolutionCallback: _localeResolutionCallback,
                home: const SettingsScreen(),
              );
            }
            return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          },
        ),
      ),
    );
  }

  Locale? _localeResolutionCallback(Locale? deviceLocale, Iterable<Locale> supportedLocales) {
    for (final local in supportedLocales) {
      if (deviceLocale != null && deviceLocale.languageCode == local.languageCode) {
        return deviceLocale;
      }
    }
    return supportedLocales.first;
  }
}