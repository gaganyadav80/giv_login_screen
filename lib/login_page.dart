import 'package:flutter/material.dart';
import 'package:giv_login_screen/registration_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'components/components.dart';
import 'components/giv_decoration.dart';

class GivLoginScreen extends StatefulWidget {
  const GivLoginScreen({
    Key? key,
    required this.onLoginButtonPressed,
    required this.onSignupButtonPressed,
    this.onGoogleButtonPressed,
    this.onForgetPasswordPressed,
    this.decoration = const GivLoginDecoration(),
  }) : super(key: key);

  final VoidCallback? onGoogleButtonPressed;

  /// Return email and password in the respective order.
  final void Function(String email, String password) onLoginButtonPressed;

  /// Return email, password and name in the respective order. If `showNameField` if false then return null value for name string.
  final void Function(String email, String password, String? name)
      onSignupButtonPressed;
  final VoidCallback? onForgetPasswordPressed;
  final GivLoginDecoration decoration;

  @override
  State<GivLoginScreen> createState() => _GivLoginScreenState();
}

class _GivLoginScreenState extends State<GivLoginScreen> {
  final _emailTextController = TextEditingController();
  final _passtextController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);

  void _onForgetPasswordPressed() {
    final _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    delayedOnPressed(() {
      showDialog(
        context: context,
        builder: (context) => PassResetMailDialog(
          formKey: _formKey,
          emailController: _emailController,
          onPressed: () {},
        ),
      );
    });
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passtextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.decoration.scaffoldBackgroundColor ??
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: widget.decoration.scaffoldBackgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: ModalRoute.of(context)!.canPop
            ? InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(LineIcons.times, color: Colors.black),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VSpace(50.0),
              'Welcome'.text.size(38.0).extraBlack.make(),
              <Widget>[
                'New here?'.text.size(18.0).make(),
                TextButton(
                  onPressed: () => delayedOnPressed(() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(
                            onSignupButtonPressed: widget.onSignupButtonPressed,
                            onGoogleButtonPressed: widget.onGoogleButtonPressed,
                          ),
                        ),
                      )),
                  child: 'Create a new account.'
                      .text
                      .size(14.0)
                      .color(widget.decoration.primaryColor ??
                          Theme.of(context).primaryColor)
                      .make(),
                ).centered(),
              ].hStack(),
              const VSpace(25.0),
              //! START LOGIN FORM
              GivLoginTextFormField(
                currentNode: _emailNode,
                nextNode: _passwordNode,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                fieldController: _emailTextController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  LineIcons.envelope,
                  color: widget.decoration.primaryColor,
                ),
              ),
              const VSpace(22.0),
              ValueListenableBuilder(
                  valueListenable: _isObscure,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return GivLoginTextFormField(
                      currentNode: _passwordNode,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      fieldController: _passtextController,
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      // validator: _validator.validatePassword,
                      obscureText: _isObscure.value,
                      prefixIcon: Icon(
                        LineIcons.lock,
                        color: widget.decoration.primaryColor,
                      ),
                      suffix: _isObscure.value
                          ? InkWell(
                              onTap: () => _isObscure.value = !_isObscure.value,
                              child: const Icon(LineIcons.eyeSlash,
                                  color: Colors.grey),
                            )
                          : InkWell(
                              onTap: () => _isObscure.value = !_isObscure.value,
                              child: Icon(LineIcons.eye,
                                  color: widget.decoration.primaryColor),
                            ),
                    );
                  }),
              const VSpace(12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onForgetPasswordPressed ??
                        _onForgetPasswordPressed,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: widget.decoration.primaryColor ??
                            Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const VSpace(12.0),
              // state is LoginInProgress
              //         ? BlueButton(
              //             title: "loading",
              //             onPressed: () {},
              //             isLoading: true,
              //           )
              //         :
              BlueButton(
                title: "Sign In",
                child: widget.decoration.loginButtonChild,
                backgroundColor: widget.decoration.loginButtonColor,
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (_emailTextController.text.isEmpty) {
                    showSnackBar(context, "Email is required");
                  } else if (_passtextController.text.isEmpty) {
                    showSnackBar(context, "Password is required");
                  } else if (!_emailTextController.text.validateEmail()) {
                    showSnackBar(context, "Invalid email");
                  } else {
                    widget.onLoginButtonPressed(
                      _emailTextController.text,
                      _passtextController.text,
                    );
                  }
                },
              ),
              //! END LOGIN FORM
              const VSpace(32.0),
              'or connect with'.text.size(14.0).make().centered(),
              const VSpace(16.0),
              Hero(
                tag: 'google-button',
                child: GoogleButton(
                  title: "Continue with Google",
                  onPressed: widget.onGoogleButtonPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
