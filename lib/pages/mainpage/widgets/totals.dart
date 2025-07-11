import 'package:expense_app/constants/const.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Totals extends StatelessWidget {
  final String text;
  final String price;
  final Widget icon;
  const Totals(
      {super.key, required this.text, required this.price, required this.icon});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return Container(
          width: width * 0.365,
          height: width * 0.365,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Constant.loginTextField,
          ),
          child: Column(
            children: [
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'vazir'),
              ),
              value.isMainPagePullToRefresh
                  ? SizedBox(
                      height: width * 0.03,
                    )
                  : const SizedBox(),
              value.isMainPagePullToRefresh
                  ? SizedBox(
                      height: width * 0.045,
                      width: width * 0.045,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text(
                      Constant.englishToPersianNumbers(price),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
              value.isMainPagePullToRefresh
                  ? SizedBox(
                      height: width * 0.049,
                    )
                  : const SizedBox(),
              icon
            ],
          ),
        );
      },
    );
  }
}
