import 'package:flutter/material.dart';

class GivLoginDecoration {
  final Color? primaryColor;
  final Color? scaffoldBackgroundColor;
  final Color? loginButtonColor;
  final Color? signupButtonColor;
  // final Color? textColor;
  final Widget? loginButtonChild;
  final Widget? signupButtonChild;

  final int? maxPasswordLength;
  final int minPasswordLength;
  final bool showNameField;

  final Widget? signupWidgetAbove;

  /// List of widget to show below the confirm password textfield. You can use `GivLoginTextFormField` to create a textfield.
  final List<Widget>? extraSignupFields;

  const GivLoginDecoration({
    this.primaryColor,
    this.scaffoldBackgroundColor,
    this.loginButtonColor,
    this.signupButtonColor,
    // this.textColor,
    this.loginButtonChild,
    this.signupButtonChild,
    this.maxPasswordLength,
    this.minPasswordLength = 6,
    this.showNameField = true,
    this.signupWidgetAbove,
    this.extraSignupFields,
  });
}
