import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class GivLoginTextFormField extends StatelessWidget {
  const GivLoginTextFormField({
    Key? key,
    required this.fieldController,
    required this.hintText,
    required this.keyboardType,
    this.currentNode,
    this.nextNode,
    required this.prefixIcon,
    this.obscureText,
    this.enabled,
    this.suffix,
    this.textCapitalization,
    this.inputFormatters,
    required this.textInputAction,
    this.validator,
    required this.maxLines,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController fieldController;
  final String hintText;
  final TextInputType keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool? enabled;
  final Widget? suffix;
  final TextInputAction textInputAction;
  final FocusNode? currentNode;
  final FocusNode? nextNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final Icon prefixIcon;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: currentNode,
      onFieldSubmitted: (value) {
        if (currentNode != null) {
          currentNode!.unfocus();
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      textInputAction: textInputAction,
      enabled: enabled ?? true,
      maxLines: maxLines,
      maxLength: maxLength,
      maxLengthEnforcement:
          maxLength != null ? MaxLengthEnforcement.enforced : null,
      controller: fieldController,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(fontSize: 14.0),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffix,
        border: kInputBorderStyle,
        focusedBorder: kInputBorderStyle,
        enabledBorder: kInputBorderStyle,
        // hintStyle:
        // Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.w),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 19.0),
        hintText: hintText,
      ),
    );
  }
}
