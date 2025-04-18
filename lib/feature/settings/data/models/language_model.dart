class Language {
  final String code;
  final String name;
  final String nativeName;
  final String flagEmoji;

  const Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flagEmoji,
  });
}

const Map<String, Language> supportedLanguages = {
  'en': Language(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    flagEmoji: '🇬🇧',
  ),
  'ar': Language(
    code: 'ar',
    name: 'Arabic',
    nativeName: 'العربية',
    flagEmoji: '🇸🇦',
  ),
};