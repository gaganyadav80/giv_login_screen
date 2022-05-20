import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'components/components.dart';
import 'components/giv_decoration.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    this.decoration = const GivLoginDecoration(),
    required this.onSignupButtonPressed,
    required this.onGoogleButtonPressed,
  }) : super(key: key);

  final GivLoginDecoration decoration;
  final VoidCallback? onGoogleButtonPressed;
  final void Function(String, String, String?) onSignupButtonPressed;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailTextController = TextEditingController();
  final _passtextController = TextEditingController();
  final _nametextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();

  final _nameNode = FocusNode();
  final _confirmPassNode = FocusNode();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isConfirmObscure = ValueNotifier<bool>(true);

  final ValueNotifier<String?> _passwordMatch = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _emailTextController.dispose();
    _passtextController.dispose();
    _nametextController.dispose();
    _confirmPassTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.decoration.scaffoldBackgroundColor ??
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(LineIcons.arrowLeft, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(20.0),
                'Sign Up'.text.size(38.0).extraBlack.make(),
                const VSpace(36.0),
                if (widget.decoration.signupWidgetAbove != null)
                  widget.decoration.signupWidgetAbove!,
                if (widget.decoration.signupWidgetAbove != null)
                  const VSpace(20.0),
                //! START REGISTER FORM
                if (widget.decoration.showNameField)
                  GivLoginTextFormField(
                    currentNode: _nameNode,
                    nextNode: _emailNode,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    fieldController: _nametextController,
                    hintText: 'Name',
                    prefixIcon: const Icon(LineIcons.user),
                    keyboardType: TextInputType.name,
                    // validator: _validator.validateName,
                  ),
                if (widget.decoration.showNameField) const VSpace(22.0),
                GivLoginTextFormField(
                  currentNode: _emailNode,
                  nextNode: _passwordNode,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  fieldController: _emailTextController,
                  hintText: 'Email',
                  prefixIcon: const Icon(LineIcons.envelope),
                  keyboardType: TextInputType.emailAddress,
                  // validator: _validator.validateEmail,
                ),
                const VSpace(22.0),
                ValueListenableBuilder(
                    valueListenable: _isObscure,
                    builder: (_, __, ___) {
                      return GivLoginTextFormField(
                        currentNode: _passwordNode,
                        nextNode: _confirmPassNode,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        maxLength: widget.decoration.maxPasswordLength,
                        fieldController: _passtextController,
                        hintText: 'Password',
                        prefixIcon: const Icon(LineIcons.lock),
                        keyboardType: TextInputType.text,
                        // validator: _validator.validatePassword,
                        obscureText: _isObscure.value,
                        suffix: _isObscure.value
                            ? InkWell(
                                onTap: () =>
                                    _isObscure.value = !_isObscure.value,
                                child: const Icon(LineIcons.eyeSlash,
                                    color: Colors.grey))
                            : InkWell(
                                onTap: () =>
                                    _isObscure.value = !_isObscure.value,
                                child: const Icon(LineIcons.eye)),
                      );
                    }),
                const VSpace(22.0),
                ValueListenableBuilder(
                  valueListenable: _passwordMatch,
                  builder: (context, String? matchValue, child) {
                    return ValueListenableBuilder(
                        valueListenable: _isConfirmObscure,
                        builder: (_, __, ___) {
                          return TextFormField(
                            focusNode: _confirmPassNode,
                            onFieldSubmitted: (value) {
                              _confirmPassNode.unfocus();
                            },
                            onChanged: (value) {
                              if (_passtextController.text ==
                                  _confirmPassTextController.text) {
                                _passwordMatch.value = null;
                              } else {
                                _passwordMatch.value =
                                    'Password does not match';
                              }
                            },
                            textInputAction: TextInputAction.done,
                            maxLines: 1,
                            maxLength: widget.decoration.maxPasswordLength,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            controller: _confirmPassTextController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            obscureText: _isConfirmObscure.value,
                            textCapitalization: TextCapitalization.none,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontSize: 14.0),
                            decoration: InputDecoration(
                              suffixIcon: _isConfirmObscure.value
                                  ? InkWell(
                                      onTap: () => _isConfirmObscure.value =
                                          !_isConfirmObscure.value,
                                      child: const Icon(LineIcons.eyeSlash,
                                          color: Colors.grey))
                                  : InkWell(
                                      onTap: () => _isConfirmObscure.value =
                                          !_isConfirmObscure.value,
                                      child: const Icon(LineIcons.eye)),
                              border: kInputBorderStyle,
                              focusedBorder: kInputBorderStyle,
                              enabledBorder: kInputBorderStyle,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              hintText: 'Confirm Password',
                              prefixIcon: const Icon(LineIcons.lock),
                              errorText: _passwordMatch.value,
                            ),
                          );
                        });
                  },
                ),
                if (widget.decoration.extraSignupFields != null)
                  const VSpace(20.0),
                Column(
                  children: widget.decoration.extraSignupFields ?? [],
                ),
                const VSpace(20.0),
                // state is RegisterInProgress
                //         ? BlueButton(
                //             title: "loading",
                //             onPressed: () {},
                //             isLoading: true,
                //           )
                //         :
                BlueButton(
                  title: "Sign Up",
                  onPressed: () {
                    if (_emailTextController.text.isEmpty) {
                      showSnackBar(context, "Email is required");
                    } else if (_passtextController.text.isEmpty) {
                      showSnackBar(context, "Password is required");
                    } else if (_confirmPassTextController.text.isEmpty) {
                      showSnackBar(context, "Confirm Password is required");
                    } else if (widget.decoration.showNameField &&
                        _nametextController.text.isEmpty) {
                      showSnackBar(context, "Name is required");
                    } else if (_passtextController.text.length <
                        widget.decoration.minPasswordLength) {
                      _passwordMatch.value = "Password is too short";
                    } else {
                      widget.onSignupButtonPressed(
                        _emailTextController.text,
                        _passtextController.text,
                        _nametextController.text,
                      );
                    }
                  },
                ),
                //! END REGISTER FORM
                const VSpace(25.0),
                'or register with'.text.size(14.0).make().centered(),
                const VSpace(16.0),
                Hero(
                  tag: 'google-button',
                  child: GoogleButton(
                    title: "Continue with Google",
                    onPressed: widget.onGoogleButtonPressed,
                  ),
                ),
                const VSpace(30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
