import 'package:expense_app/constants/const.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sections extends StatelessWidget {
  final int section;
  final String text;
  const Sections({
    required this.section,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: section == value.secetionIndex
                      ? Colors.white
                      : Constant.sectionUnselected,
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.044,
                  fontFamily: 'vazir'),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: height * 0.008,
              width: height * 0.008,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: section == value.secetionIndex
                    ? const Color.fromARGB(255, 218, 114, 148)
                    : Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  }
}
