import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizations_app/app/localizations/localizations_cache_helper.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LocalizationCacheHelper _localizationCacheHelper;

  SettingsBloc({LocalizationCacheHelper? localizationCacheHelper})
      : _localizationCacheHelper = localizationCacheHelper ?? LocalizationCacheHelper(),
        super(const SettingsInitial()) {
    on<GetSavedLanguageEvent>(_onGetSavedLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onGetSavedLanguage(
      GetSavedLanguageEvent event,
      Emitter<SettingsState> emit,
      ) async {
    try {
      final languageCode = await _localizationCacheHelper.getCachedLanguageCode();
      emit(LanguageChangedState(Locale(languageCode))); // القيمة الافتراضية 'en'
    } catch (e) {
      emit(SettingsErrorState('Failed to load language: ${e.toString()}'));
      emit(LanguageChangedState(const Locale('en'))); // Fallback to English
    }
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event,
      Emitter<SettingsState> emit,
      ) async {
    try {
      await _localizationCacheHelper.cacheLanguageCode(event.languageCode);
      emit(LanguageChangedState(Locale(event.languageCode)));
    } catch (e) {
      emit(SettingsErrorState('Failed to change language: ${e.toString()}'));
    }
  }

  // Future<void> _onGetSavedLanguage(
  //     GetSavedLanguageEvent event,
  //     Emitter<SettingsState> emit,
  //     ) async {
  //   try {
  //     final languageCode = await _localizationCacheHelper.getCachedLanguageCode();
  //     if (languageCode != null) {
  //       emit(LanguageChangedState(Locale(languageCode)));
  //     } else {
  //       // Default language if none is saved
  //       emit(LanguageChangedState(const Locale('en')));
  //     }
  //   } catch (e) {
  //     emit(SettingsErrorState('Failed to load saved language: ${e.toString()}'));
  //   }
  // }


  // Future<void> _onChangeLanguage(
  //     ChangeLanguageEvent event,
  //     Emitter<SettingsState> emit,
  //     ) async {
  //   try {
  //     await _localizationCacheHelper.cacheLanguageCode(event.languageCode);
  //     emit(LanguageChangedState(Locale(event.languageCode)));
  //   } catch (e) {
  //     emit(SettingsErrorState('Failed to change language: ${e.toString()}'));
  //   }
  // }
}