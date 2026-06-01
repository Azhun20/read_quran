import 'package:flutter/material.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';
import 'package:read_quran/shared/domain/entities/quran/ayah_entity.dart';

class AyahCard extends StatefulWidget {
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
  State<AyahCard> createState() => _AyahCardState();
}

class _AyahCardState extends State<AyahCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasTranslation =
        widget.ayah.translation != null && widget.ayah.translation!.isNotEmpty;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border.all(
            color: widget.isPlaying
                ? context.colorScheme.primary
                : context.colorScheme.outlineVariant.withOpacity(0.3),
            width: widget.isPlaying ? 2 : 1,
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
                    color: widget.isPlaying
                        ? context.colorScheme.primary
                        : context.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${widget.ayah.numberInSurah}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: widget.isPlaying
                            ? Colors.white
                            : context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                if (widget.isPlaying)
                  Icon(
                    Icons.volume_up,
                    color: context.colorScheme.primary,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Arabic text
                  Text(
                    widget.ayah.text ?? '',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Rajdhani',
                      height: 1.8,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),

                  // Divider and translation
                  if (hasTranslation) ...[
                    const SizedBox(height: 12),
                    Divider(
                      color: context.colorScheme.outlineVariant.withOpacity(
                        0.3,
                      ),
                      thickness: 1,
                    ),
                    const SizedBox(height: 12),

                    // Translation text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ayah.translation!,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurface.withOpacity(
                              0.8,
                            ),
                            height: 1.6,
                          ),
                          maxLines: _isExpanded ? null : 2,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        ),

                        // See all / See less button
                        if (widget.ayah.translation!.length > 80)
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                _isExpanded ? 'See less' : 'See all',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
