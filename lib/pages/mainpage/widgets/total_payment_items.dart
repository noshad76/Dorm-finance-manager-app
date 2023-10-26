import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_app/constants/const.dart';
import 'package:expense_app/models/payment_model.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TotalsPaymentItems extends StatelessWidget {
  final int index;
  final Payment payment;

  final ImageProvider<Object>? backgroundImage;

  const TotalsPaymentItems({
    required this.backgroundImage,
    required this.index,
    super.key,
    required this.payment,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String usersShouldPay = '';
    for (var element in payment.users) {
      usersShouldPay += '${element.name} , ';
    }

    if (usersShouldPay.isNotEmpty) {
      usersShouldPay = usersShouldPay.substring(0, usersShouldPay.length - 2);
    }
    String userPaid = '';
    if (payment.paidBy != null || payment.paidBy!.isNotEmpty) {
      for (var intElement in payment.paidBy!) {
        for (var userElement in payment.users) {
          if (userElement.id == intElement) {
            userPaid += '${userElement.name} , ';
          }
        }
      }
    }
    if (userPaid.isNotEmpty) {
      userPaid = userPaid.substring(0, userPaid.length - 2);
    }

    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    Constant.cardColors[index % Constant.cardColors.length]),
            border: Border.all(
              width: 3,
              strokeAlign: -1,
              color: const Color(
                0xFF191c47,
              ),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          height: height * 0.155,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: height * 0.4,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Constant.loginTextField),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'جزئیات بیشتر',
                              style: TextStyle(
                                  fontFamily: 'vazir',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.045),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     SizedBox(
                            //       width: width * 0.7,
                            //       child: AutoSizeText(
                            //         'افزوده شده توسط : ${payment.createdBy!.name}',
                            //         maxLines: 5,
                            //         overflow: TextOverflow.ellipsis,
                            //         textAlign: TextAlign.right,
                            //         style: const TextStyle(
                            //           fontFamily: 'vazir',
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     SizedBox(
                            //       width: width * 0.7,
                            //       child: AutoSizeText(
                            //         'موضوع : ${payment.title}',
                            //         maxLines: 5,
                            //         overflow: TextOverflow.ellipsis,
                            //         textAlign: TextAlign.right,
                            //         style: const TextStyle(
                            //           fontFamily: 'vazir',
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width * 0.7,
                                  child: AutoSizeText(
                                    payment.description.length <= 1
                                        ? ': توضیحات'
                                        : 'توضیحات : ${payment.description}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width * 0.7,
                                  child: AutoSizeText(
                                    'تاریخ : ${value.dateFormatter(Jalali.fromDateTime(DateTime.fromMillisecondsSinceEpoch(value.allPayemnts[index]!.date * 1000)))}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     SizedBox(
                            //       width: width * 0.7,
                            //       child: AutoSizeText(
                            //         'قیمت : ${value.formatAmount(payment.price.toString())} تومان',
                            //         maxLines: 5,
                            //         overflow: TextOverflow.ellipsis,
                            //         textAlign: TextAlign.right,
                            //         style: const TextStyle(
                            //           fontFamily: 'vazir',
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width * 0.7,
                                  child: AutoSizeText(
                                    'افراد سهیم در خرید : $usersShouldPay',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width * 0.7,
                                  child: AutoSizeText(
                                    payment.description.length <= 1
                                        ? ': افرادي که پرداخت کرده اند'
                                        : 'افرادي که پرداخت کرده اند : $userPaid',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
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
                            Text(value.formatAmount((payment.price).toString()),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.06,
                                    fontWeight: FontWeight.bold)),
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
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/1.jpg'),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Icon(
                              Icons.attach_money_rounded,
                              size: width * 0.055,
                              color: Colors.white54,
                            ),
                            Text(
                              value.formatAmount(
                                  (payment.price ~/ (payment.users.length + 1))
                                      .toString()),
                              style: GoogleFonts.inter(
                                  color: Colors.white54,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold),
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
                                      value.allPayemnts[index]!.date * 1000))),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
