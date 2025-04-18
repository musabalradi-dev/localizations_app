part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();

  @override
  String toString() => 'SettingsInitial';
}

class LanguageChangedState extends SettingsState {
  final Locale locale;

  const LanguageChangedState(this.locale);

  @override
  List<Object> get props => [locale];

  @override
  String toString() => 'LanguageChangedState(locale: ${locale.languageCode})';
}

class SettingsErrorState extends SettingsState {
  final String message;

  const SettingsErrorState(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SettingsErrorState(message: $message)';
}