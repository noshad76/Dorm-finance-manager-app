import 'package:expense_app/constants/const.dart';
import 'package:flutter/material.dart';

class ElevatedbuttonModal extends StatelessWidget {
  const ElevatedbuttonModal({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final Widget text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(8),
          backgroundColor:
              const MaterialStatePropertyAll(Constant.loginTextField),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(MediaQuery.of(context).size.width * 0.35, 60),
          ),
        ),
        onPressed: onPressed,
        child: text);
  }
}
