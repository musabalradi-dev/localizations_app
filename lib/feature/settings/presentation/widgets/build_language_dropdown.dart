import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:localizations_app/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:localizations_app/feature/settings/presentation/widgets/get_language_name.dart';

Widget buildLanguageDropdown(BuildContext context, Locale currentLocale) {
  final theme = Theme.of(context);
  final currentLanguageCode = currentLocale.languageCode;
  // final isArabic = currentLanguageCode == 'ar';

  return DropdownButtonHideUnderline(
    child: DropdownButton2<String>(
      value: currentLanguageCode.isNotEmpty ? currentLanguageCode : 'en',
      buttonStyleData: ButtonStyleData(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1.5,
          ),
          color: theme.colorScheme.surface,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.colorScheme.surface,
        ),
        elevation: 4,
        offset: const Offset(0, -8),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          size: 28,
        ),
        iconEnabledColor: theme.colorScheme.primary,
        iconDisabledColor: theme.colorScheme.onSurface.withValues(alpha: 0.3),
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      items: ['en', 'ar'].map((languageCode) {
        final isSelected = languageCode == currentLanguageCode;
        return DropdownMenuItem<String>(
          value: languageCode,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: Text(
                      languageCode == 'en' ? '🇬🇧' : '🇸🇦',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    getLanguageName(languageCode),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.check_circle_rounded,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null && value != currentLanguageCode) {
          Feedback.forTap(context);
          context.read<SettingsBloc>().add(ChangeLanguageEvent(value));
        }
      },
      dropdownSearchData: DropdownSearchData(
        searchController: TextEditingController(),
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search language...',
              hintStyle: theme.textTheme.bodySmall,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value.toString().toLowerCase().contains(
            searchValue.toLowerCase(),
          ) ||
              getLanguageName(item.value!)
                  .toLowerCase()
                  .contains(searchValue.toLowerCase());
        },
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 48,
        padding: EdgeInsets.zero,
      ),
    ),
  );
}