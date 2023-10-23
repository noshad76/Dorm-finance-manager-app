import 'package:expense_app/constants/const.dart';
import 'package:flutter/material.dart';

class Totals extends StatelessWidget {
  final String text;
  final String price;
  final Widget icon;
  const Totals(
      {super.key, required this.text, required this.price, required this.icon});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          SizedBox(
            height: width * 0.02,
          ),
          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: width * 0.03,
          ),
          icon
        ],
      ),
    );
  }
}
