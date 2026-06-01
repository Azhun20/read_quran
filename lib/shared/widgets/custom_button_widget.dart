import 'package:flutter/material.dart';
import 'package:read_quran/shared/styles/color_style.dart';
import 'package:read_quran/utils/extensions/theme_context_extension.dart';

/// Enum defining the visual style variants for [CustomButtonWidget].
///
/// - [filled]: Solid background color with contrasting text (primary CTA)
/// - [outlined]: Transparent background with colored border (secondary actions)
/// - [text]: Minimal style with no background or border (tertiary actions)
enum TButtonType { filled, outlined, text }

/// A highly customizable button widget with multiple style variants.
///
/// This widget provides a consistent button interface across the Read Quran app
/// with support for different visual styles (filled, outlined, text), loading states,
/// icon placement, and responsive sizing. It handles all button states automatically
/// including disabled, pressed, and loading.
///
/// **Features**:
/// - **Three Style Variants**: Filled, outlined, and text buttons
/// - **Loading State**: Shows circular progress indicator
/// - **Icon Support**: Optional prefix and suffix icons
/// - **Responsive**: Expanded mode for full-width buttons
/// - **Accessibility**: Proper disabled state with reduced opacity
/// - **Material Design**: Ink splash and highlight effects
/// - **Themeable**: Customizable colors, padding, and text style
///
/// **Button Types**:
/// 1. **Filled** (Primary CTA):
///    - Solid background color (defaults to primary500)
///    - White text color
///    - Used for primary actions like "Save", "Submit"
///
/// 2. **Outlined** (Secondary):
///    - Transparent background
///    - Colored border (defaults to primary500)
///    - Colored text (defaults to primary500)
///    - Used for secondary actions like "Cancel", "Skip"
///
/// 3. **Text** (Tertiary):
///    - No background or border
///    - Colored text (defaults to primary500)
///    - Used for low-emphasis actions like "Learn More"
///
/// **State Handling**:
/// - **Disabled**: When onPressed is null
///   - Reduced opacity (0.6)
///   - Gray colors
///   - No interaction
/// - **Loading**: When isLoading is true
///   - Shows circular progress indicator
///   - Disables button interaction
///   - Hides icon if present
///
/// **Usage Examples**:
/// ```dart
/// // Filled button (primary action)
/// CustomButtonWidget.filled(
///   text: 'Save Changes',
///   onPressed: () => _saveChanges(),
/// )
///
/// // Outlined button with icon
/// CustomButtonWidget.outlined(
///   text: 'Select Reciter',
///   prefixIcon: Icon(Icons.volume_up),
///   onPressed: () => _selectReciter(),
/// )
///
/// // Loading state
/// CustomButtonWidget.filled(
///   text: 'Submitting...',
///   isLoading: true,
/// )
///
/// // Full-width button
/// CustomButtonWidget.filled(
///   text: 'Continue',
///   expanded: true,
///   onPressed: () => _continue(),
/// )
///
/// // Disabled button
/// CustomButtonWidget.filled(
///   text: 'Submit',
///   onPressed: null, // Disabled when null
/// )
/// ```
class CustomButtonWidget extends StatelessWidget {
  /// The text label displayed on the button.
  final String text;

  /// Callback function executed when the button is pressed.
  ///
  /// If null, the button is considered disabled and cannot be interacted with.
  final VoidCallback? onPressed;

  /// The visual style variant of the button.
  ///
  /// Determines the button's appearance: filled, outlined, or text.
  /// Defaults to [TButtonType.filled].
  final TButtonType type;

  /// Custom background color for the button.
  ///
  /// Only applies to filled buttons. If null, uses primary500 from ColorStyle.
  final Color? backgroundColor;

  /// Custom text color for the button label.
  ///
  /// If null, uses appropriate contrast color based on button type:
  /// - Filled: white
  /// - Outlined/Text: primary500
  final Color? textColor;

  /// Custom border color for outlined buttons.
  ///
  /// Only applies to outlined buttons. If null, uses primary500 from ColorStyle.
  final Color? borderColor;

  /// Fixed width for the button.
  ///
  /// If null, button width is determined by its content or [expanded] parameter.
  final double? width;

  /// Fixed height for the button.
  ///
  /// If null, height is determined by padding and content.
  final double? height;

  /// Custom padding inside the button.
  ///
  /// Defaults to EdgeInsets.symmetric(horizontal: 16, vertical: 12).
  final EdgeInsetsGeometry? padding;

  /// Custom border radius for the button corners.
  ///
  /// Defaults to BorderRadius.circular(8).
  final BorderRadius? borderRadius;

  /// Custom text style for the button label.
  ///
  /// If null, uses theme-appropriate text style from context extensions.
  final TextStyle? textStyle;

  /// Optional icon displayed before the text label.
  ///
  /// Hidden when [isLoading] is true.
  final Widget? prefixIcon;

  /// Optional icon displayed after the text label.
  ///
  /// Hidden when [isLoading] is true.
  final Widget? suffixIcon;

  /// Whether to show a loading indicator instead of the text.
  ///
  /// When true, displays a circular progress indicator and disables interaction.
  final bool isLoading;

  /// Whether the button should expand to fill available width.
  ///
  /// When true, button takes full width of parent container.
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

  /// Creates a filled button with solid background color.
  ///
  /// This factory constructor creates a primary call-to-action button with
  /// solid background and contrasting text. Use for the most important
  /// action on a screen.
  ///
  /// **Default Styling**:
  /// - Background: primary500 color
  /// - Text: White
  /// - Type: TButtonType.filled
  ///
  /// **Example**:
  /// ```dart
  /// CustomButtonWidget.filled(
  ///   text: 'Continue',
  ///   onPressed: () => _handleContinue(),
  ///   prefixIcon: Icon(Icons.arrow_forward),
  /// )
  /// ```
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

  /// Creates an outlined button with transparent background and colored border.
  ///
  /// This factory constructor creates a secondary action button with a border
  /// and no background fill. Use for secondary actions that need less emphasis
  /// than primary buttons.
  ///
  /// **Default Styling**:
  /// - Background: Transparent
  /// - Border: primary500 color
  /// - Text: primary500 color
  /// - Type: TButtonType.outlined
  ///
  /// **Example**:
  /// ```dart
  /// CustomButtonWidget.outlined(
  ///   text: 'Cancel',
  ///   onPressed: () => Navigator.pop(context),
  /// )
  /// ```
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

  /// Creates a minimal text-only button with no background or border.
  ///
  /// This factory constructor creates a tertiary action button with minimal
  /// visual weight. Use for low-emphasis actions or inline links.
  ///
  /// **Default Styling**:
  /// - Background: None
  /// - Border: None
  /// - Text: primary500 color
  /// - Type: TButtonType.text
  ///
  /// **Example**:
  /// ```dart
  /// CustomButtonWidget.text(
  ///   text: 'Learn More',
  ///   onPressed: () => _showInfoDialog(),
  /// )
  /// ```
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
