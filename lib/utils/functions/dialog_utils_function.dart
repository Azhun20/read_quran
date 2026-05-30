import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:read_quran/constants/asset_consstant.dart';
import 'package:read_quran/shared/styles/color_style.dart';
import 'package:read_quran/shared/widgets/custom_button_widget.dart';
import 'package:read_quran/utils/extensions/theme_context_extension.dart';

class DialogUtilsFunction {
  static Flushbar? _currentFlushbar;

  static void showGlobalLoading(BuildContext context, {String? text}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      fullscreenDialog: true,

      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              if (text != null) ...[
                const SizedBox(height: 16),
                Text(
                  text,
                  style: context.body2Medium.copyWith(color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static void closeGlobalLoading(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  static void _showSnackbar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required IconData iconData,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onDismiss,
  }) {
    if (_currentFlushbar?.isShowing() ?? false) {
      _currentFlushbar?.dismiss();
    }

    _currentFlushbar = Flushbar<void>(
      messageText: Text(
        message,
        style: context.body2Regular.copyWith(color: textColor),
      ),
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      icon: Icon(iconData, color: textColor),
      duration: duration,
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          _currentFlushbar = null;
          onDismiss?.call();
        }
      },
    )..show(context);
  }

  static void showErrorSnackbar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onDismiss,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: ColorStyle.secondary50,
      textColor: ColorStyle.secondary500,
      iconData: Icons.cancel,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  static void showSuccessSnackbar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onDismiss,
  }) {
    _showSnackbar(
      context,
      message: message,
      backgroundColor: ColorStyle.success50,
      textColor: ColorStyle.success500,
      iconData: Icons.check_circle,
      duration: duration,
      onDismiss: onDismiss,
    );
  }

  static void showInformationDialog(
    BuildContext context, {
    required String svgAsset,
    required String title,
    required String subtitle,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(svgAsset, width: 160, height: 160),
              const SizedBox(height: 16),
              Text(
                title,
                style: context.heading1Bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: context.body1Regular.copyWith(color: context.neutral100),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButtonWidget.filled(
                text: 'OK',
                onPressed: () => Navigator.of(context).pop(),
                expanded: true,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String subtitle,
    String confirmText = 'Ya',
    String cancelText = 'Batal',
    bool isNegativeConfirm = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AssetConstants.icWarning,
                width: 160,
                height: 160,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: context.heading1Bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: context.body1Regular.copyWith(color: context.neutral100),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: isNegativeConfirm
                    ? CustomButtonWidget.outlined(
                        borderColor: ColorStyle.secondary500,
                        textColor: ColorStyle.secondary500,
                        text: confirmText,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      )
                    : CustomButtonWidget.filled(
                        text: confirmText,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: isNegativeConfirm
                    ? CustomButtonWidget.filled(
                        text: cancelText,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      )
                    : CustomButtonWidget.outlined(
                        text: cancelText,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Shows a success dialog with icon, title, message, and OK button
  static Future<void> showSuccessDialog(
    BuildContext context, {
    required String title,
    String? message,
    String buttonText = "OK",
    VoidCallback? onConfirm,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Illustration
                SvgPicture.asset(
                  AssetConstants.icSuccessIlustration,
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 24),
                // Title
                Text(
                  title,
                  style: context.body1SemiBold.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                if (message != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: context.body2Regular.copyWith(
                      color: ColorStyle.neutral400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                // OK Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      if (onConfirm != null) onConfirm();
                    },
                    child: Text(buttonText, style: context.body2SemiBold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
