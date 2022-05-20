import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

import 'constants.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  const GoogleButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        // color: Theme.of(context).scaffoldBackgroundColor,
        // primary: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
          side: kInputBorderStyle.borderSide,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   'assets/google.svg',
          //   alignment: Alignment.center,
          //   // fit: BoxFit.contain,
          //   height: 26.0,
          //   width: 26.0,
          // ),
          const Icon(LineIcons.googlePlay),
          const SizedBox(width: 20.0),
          Text(title, style: Theme.of(context).textTheme.button!)
        ],
      ),
    );
  }
}
