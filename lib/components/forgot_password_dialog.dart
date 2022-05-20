import 'package:flutter/material.dart';

import 'constants.dart';
import 'custom_form_field.dart';

class PassResetMailDialog extends StatelessWidget {
  final Function onPressed;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  const PassResetMailDialog({
    Key? key,
    required this.onPressed,
    required this.formKey,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      title: Text(
        "Forgot Password",
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
            ),
      ),
      content: SizedBox(
        width: 315.0,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              GivLoginTextFormField(
                fieldController: emailController,
                hintText: "Enter registered email",
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                // validator: Validator().validateEmail,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: onPressed as void Function()?,
          child: const Text("CONFIRM"),
        ),
      ],
    );
  }
}
