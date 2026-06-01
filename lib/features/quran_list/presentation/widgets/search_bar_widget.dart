import 'package:flutter/material.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.focusNode,
  });

  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onTapOutside: (_) => focusNode.unfocus(),
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: 'Search by name or number...',
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
