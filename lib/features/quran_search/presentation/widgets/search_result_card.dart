import 'package:flutter/material.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.ayah,
    required this.searchKeyword,
    required this.onTap,
  });

  final AyahEntity ayah;
  final String searchKeyword;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.all(
            color: context.colorScheme.outlineVariant.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Surah name and ayah number
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ayah.surahEnglishName ?? 'Surah ${ayah.surahNumber}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Ayah ${ayah.numberInSurah}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: context.colorScheme.primary,
                  size: 20,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Arabic text
            SizedBox(
              width: double.infinity,
              child: Text(
                ayah.text ?? '',
                style: context.textTheme.titleLarge?.copyWith(
                  fontFamily: 'Rajdhani',
                  height: 1.8,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),

            const SizedBox(height: 8),

            // Location info
            Row(
              children: [
                Icon(
                  Icons.menu_book,
                  size: 14,
                  color: context.colorScheme.onSurface.withOpacity(0.5),
                ),
                const SizedBox(width: 4),
                Text(
                  'Juz ${ayah.juz ?? '-'} " Page ${ayah.page ?? '-'}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
