import 'package:flutter/material.dart';
import 'package:read_quran/shared/styles/color_style.dart';
import 'package:read_quran/utils/extensions/theme_context_extension.dart';

enum TButtonType { filled, outlined, text }

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TButtonType type;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isLoading;
  final bool expanded;

  const CustomButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.type = TButtonType.filled,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.expanded = false,
  });

  // Factory constructor untuk filled button
  factory CustomButtonWidget.filled({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isLoading = false,
    bool expanded = false,
  }) {
    return CustomButtonWidget(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      textStyle: textStyle,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isLoading: isLoading,
      expanded: expanded,
    );
  }

  // Factory constructor untuk outlined button
  factory CustomButtonWidget.outlined({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    Color? borderColor,
    Color? textColor,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isLoading = false,
    bool expanded = false,
    Color? backgroundColor,
  }) {
    return CustomButtonWidget(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      type: TButtonType.outlined,
      borderColor: borderColor,
      textColor: textColor,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      textStyle: textStyle,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isLoading: isLoading,
      expanded: expanded,
    );
  }

  // Factory constructor untuk text button
  factory CustomButtonWidget.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    Color? textColor,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isLoading = false,
    bool expanded = false,
  }) {
    return CustomButtonWidget(
      key: key,
      text: text,
      onPressed: onPressed,
      type: TButtonType.text,
      textColor: textColor,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      textStyle: textStyle,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isLoading: isLoading,
      expanded: expanded,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    // Tentukan warna berdasarkan state dan type
    Color getBackgroundColor() {
      if (type == TButtonType.filled) {
        if (isDisabled) return Colors.grey[300]!;
        return backgroundColor ?? ColorStyle.primary500;
      }
      return Colors.transparent;
    }

    Color getTextColor() {
      if (isDisabled) {
        return Colors.grey[500]!;
      }

      if (textColor != null) return textColor!;

      if (type == TButtonType.filled) {
        return Colors.white;
      }
      return ColorStyle.primary500;
    }

    Color? getBorderColor() {
      if (type == TButtonType.outlined) {
        if (isDisabled) return Colors.grey[300];
        return borderColor ?? ColorStyle.primary500;
      }
      return null;
    }

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: SizedBox(
        width: expanded ? double.infinity : width,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isDisabled || isLoading ? null : onPressed,
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            splashColor: type == TButtonType.filled
                ? Colors.white.withValues(alpha: 0.2)
                : ColorStyle.primary500.withValues(alpha: 0.1),
            highlightColor: type == TButtonType.filled
                ? Colors.white.withValues(alpha: 0.1)
                : ColorStyle.primary500.withValues(alpha: 0.05),
            child: Ink(
              height: height,
              padding:
                  padding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: getBackgroundColor(),
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                border: getBorderColor() != null
                    ? Border.all(color: getBorderColor()!)
                    : null,
              ),
              child: Row(
                mainAxisSize: expanded || width != null
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null && !isLoading) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  if (isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          type == TButtonType.filled
                              ? Colors.white
                              : ColorStyle.primary500,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            textStyle?.copyWith(color: getTextColor()) ??
                            (type == TButtonType.outlined
                                ? context.body2Medium.copyWith(
                                    color: getTextColor(),
                                  )
                                : context.body2SemiBold.copyWith(
                                    color: getTextColor(),
                                  )),
                      ),
                    ),
                  if (suffixIcon != null && !isLoading) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
