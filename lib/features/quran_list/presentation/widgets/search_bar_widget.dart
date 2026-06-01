import 'package:flutter/material.dart';
import 'package:read_quran/core/extensions/context_extensions.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.onChanged,
    required this.focusNode,
    required this.textController,
  });

  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ValueListenableBuilder(
        valueListenable: textController,
        builder: (context, value, child) {
          return TextField(
            controller: textController,
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
              suffixIcon: value.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        focusNode.unfocus();
                        textController.clear();
                        onChanged('');
                      },
                    ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            style: context.textTheme.bodyMedium,
          );
        },
      ),
    );
  }
}
