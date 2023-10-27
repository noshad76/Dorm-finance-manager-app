import 'package:expense_app/constants/const.dart';
import 'package:expense_app/state/login_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Formfield extends StatelessWidget {
  final String hint;
  final String icon;
  const Formfield({
    super.key,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInPageProvider>(
      builder: (context, logInPageProvider, child) {
        return Container(
          padding: const EdgeInsets.only(left: 20, top: 3),
          height: 60,
          decoration: BoxDecoration(
            color: Constant.loginTextField,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(0, 5),
                spreadRadius: -4,
              )
            ],
            border: Border.all(
              color: Constant.loginTextField,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 217,
                height: 60,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (hint == 'رمز عبور') {
                      logInPageProvider.mainPagePassword = value;
                    } else {
                      logInPageProvider.mainPageUserName = value;
                    }
                  },
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.ltr,
                  keyboardType:
                      hint == 'رمز عبور' ? TextInputType.visiblePassword : null,
                  obscureText: hint == 'رمز عبور' ? true : false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                        fontFamily: 'vazir',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Constant.loginTextfieldContent),
                    hintTextDirection: TextDirection.rtl,
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: 30,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    errorStyle: const TextStyle(fontSize: 0, height: 1),
                    focusedErrorBorder: InputBorder.none,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      gapPadding: 50,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(
                icon,
                height: 30,
                colorFilter: const ColorFilter.mode(
                  Constant.loginTextfieldContent,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
