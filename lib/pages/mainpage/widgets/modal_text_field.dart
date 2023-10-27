import 'package:expense_app/constants/const.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalTextField extends StatelessWidget {
  final String hint;
  final bool isBig;
  final int index;

  const ModalTextField({
    required this.index,
    required this.hint,
    required this.isBig,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<MainPageProvider>(
      builder: (context, mainPageProvider, child) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Constant.loginTextField,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: height * 0.006,
                  offset: Offset(0, height * 0.006),
                  spreadRadius: -height * 0.005,
                )
              ]),
          child: TextFormField(
            textDirection: TextDirection.rtl,
            keyboardType: index == 1 ? TextInputType.number : null,
            onChanged: (value) {
              if (index == 0) {
                mainPageProvider.title = value;
              } else if (index == 1) {
                mainPageProvider.price = value;
              } else if (index == 2) {
                mainPageProvider.description = value;
              }
            },
            onTap: () {
              mainPageProvider.changeselectedTextbox(index);
            },
            maxLines: isBig ? 4 : 1,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(width * 0.05),
              hintText: isBig
                  ? '$hint\n--------------------------------------------------------------------------------'
                  : hint,
              hintStyle: TextStyle(
                  fontFamily: 'vazir',
                  fontSize: width * 0.043,
                  fontWeight: FontWeight.bold,
                  color: Constant.loginTextfieldContent),
              hintTextDirection: TextDirection.rtl,
              suffixIconConstraints: BoxConstraints(
                maxWidth: width * 0.07,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                gapPadding: width * 0.1,
                borderRadius: BorderRadius.all(
                  Radius.circular(width * 0.1),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
