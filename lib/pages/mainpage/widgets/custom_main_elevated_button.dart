import 'package:expense_app/constants/const.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomMainElevatedButton extends StatelessWidget {
  final void Function() onpressed;
  const CustomMainElevatedButton({
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return ElevatedButton(
          onPressed: onpressed,
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(width * 0.01),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(width * 0.1)))),
            minimumSize:
                MaterialStatePropertyAll(Size(width * 0.4, width * 0.152)),
            backgroundColor: const MaterialStatePropertyAll(Constant.loginTextField),
          ),
          child: value.isLoadingAddPayment
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'افزودن',
                      style: TextStyle(
                          fontFamily: 'vazir',
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.add,
                      size: width * 0.08,
                    )
                  ],
                ),
        );
      },
    );
  }
}
