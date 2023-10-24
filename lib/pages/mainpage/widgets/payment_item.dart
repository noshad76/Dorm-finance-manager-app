import 'package:expense_app/constants/const.dart';
import 'package:expense_app/models/payment_model.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PaymentItem extends StatelessWidget {
  final int index;
  final Payment payment;
  final ImageProvider<Object>? backgroundImage;

  const PaymentItem({
    required this.backgroundImage,
    required this.index,
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            value.changeselectedCardIndex(index);
            if (value.selectedCardIndex == index) {
              value.cardAnimationToFalse();
            }
          },
          child: AnimatedContainer(
            onEnd: () {
              value.changecardAnimation();
            },
            duration: const Duration(milliseconds: 100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: Constant.cardColors[index]),
              border: Border.all(
                  width: width * 0.007,
                  strokeAlign: -width * 0.002,
                  color: Constant.paymentBorders),
              borderRadius: BorderRadius.circular(width * 0.07),
            ),
            height: value.selectedCardIndex == index
                ? height * 0.15
                : height * 0.07,
            width: width * 0.6,
            child: Padding(
              padding: EdgeInsets.all(width * 0.014),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            size: width * 0.07,
                            color: Colors.white,
                          ),
                          Text(value.formatAmount('${payment.price}'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            payment.title,
                            style: TextStyle(
                                fontFamily: 'vazir',
                                color: Colors.white,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/1.jpg'),
                          )
                        ],
                      )
                    ],
                  ),
                  value.cardAnimation[index] == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money_rounded,
                                      size: width * 0.05,
                                      color: Colors.white38,
                                    ),
                                    Text(
                                      value.formatAmount((payment.price ~/
                                              (payment.users.length + 1))
                                          .toString()),
                                      style: GoogleFonts.inter(
                                          color: Colors.white54,
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  value.dateFormatter(Jalali.fromDateTime(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          value.allPayemnts[index]!.date *
                                              1000))),
                                  style: TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white38,
                                      fontSize: width * 0.027,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: width * 0.35,
                                  child: Text(
                                    'پرداخت به ${payment.createdBy!.name}\n${payment.description}',
                                    textDirection: TextDirection.rtl,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'vazir',
                                        height: width * 0.003,
                                        color: Colors.white,
                                        fontSize: width * 0.026,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
