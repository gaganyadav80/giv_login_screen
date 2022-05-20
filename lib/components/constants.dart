import 'package:flutter/material.dart';

final kBorderRadius = BorderRadius.circular(3.0);

final kInputBorderStyle = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: const BorderSide(
    width: 1.0,
    // color: Colors.grey[400]!,
    color: Colors.black54,
  ),
);

class VSpace extends StatelessWidget {
  const VSpace(this.height, {Key? key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HSpace extends StatelessWidget {
  const HSpace(this.width, {Key? key}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

void delayedOnPressed(VoidCallback callback) =>
    Future.delayed(const Duration(milliseconds: 200), () => callback());

void showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
