import 'package:flutter/material.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class AyahCard extends StatelessWidget {
  const AyahCard({
    super.key,
    required this.ayah,
    required this.isPlaying,
    required this.onTap,
  });

  final AyahEntity ayah;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isPlaying
              ? context.colorScheme.primaryContainer.withOpacity(0.3)
              : context.colorScheme.surface,
          border: Border.all(
            color: isPlaying
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant.withOpacity(0.3),
            width: isPlaying ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isPlaying
                        ? context.colorScheme.primary
                        : context.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${ayah.numberInSurah}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isPlaying
                            ? Colors.white
                            : context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                if (isPlaying)
                  Icon(
                    Icons.volume_up,
                    color: context.colorScheme.primary,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
