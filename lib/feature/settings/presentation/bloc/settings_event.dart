part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class GetSavedLanguageEvent extends SettingsEvent {
  const GetSavedLanguageEvent();

  @override
  String toString() => 'GetSavedLanguageEvent';
}

class ChangeLanguageEvent extends SettingsEvent {
  final String languageCode;

  const ChangeLanguageEvent(this.languageCode);

  @override
  List<Object> get props => [languageCode];

  @override
  String toString() => 'ChangeLanguageEvent(languageCode: $languageCode)';
}