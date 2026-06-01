import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  // ============== Theme ==============
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get errorColor => colorScheme.error;

  // ============== MediaQuery ==============
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  // ============== Navigation ==============
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  bool get canPop => Navigator.of(this).canPop();

  // ============== BLoC ==============
  T readBloc<T extends BlocBase>() => read<T>();
  T watchBloc<T extends BlocBase>() => watch<T>();

  // ============== SnackBar ==============
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), duration: duration),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ============== Focus ==============
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}
