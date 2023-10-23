import 'package:expense_app/constants/const.dart';
import 'package:expense_app/models/payment_model.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentNotification extends StatelessWidget {
  final int index;
  final Payment payment;

  const PaymentNotification({
    required this.index,
    required this.payment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.only(left: width * 0.006),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.01),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: Constant
                          .cardColors[index % Constant.cardColors.length]),
                  border: Border.all(
                    width: 3,
                    strokeAlign: -1,
                    color: const Color(
                      0xFF191c47,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(width * 0.07),
                ),
                height: height * 0.125,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.01),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            payment.title,
                            style: TextStyle(
                                fontFamily: 'vazir',
                                color: Colors.white,
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          CircleAvatar(
                            radius: width * 0.042,
                            backgroundImage:
                                const AssetImage('assets/images/1.jpg'),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.025,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money_rounded,
                                      size: width * 0.06,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      value.formatAmount((payment.price ~/
                                              (payment.users.length + 1))
                                          .toString()),
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: width * 0.05,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    size: width * 0.05,
                                    color: Colors.white38,
                                  ),
                                  Text(
                                    value.formatAmount(
                                        payment.price.toInt().toString()),
                                    style: GoogleFonts.inter(
                                        color: Colors.white38,
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'دوشنبه 18 آبان',
                                  style: TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white38,
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                SizedBox(
                                  width: width * 0.3,
                                  child: Text(
                                    'پرداخت به ${payment.createdBy!.name}',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontFamily: 'vazir',
                                        height: height * 0.001,
                                        color: Colors.white,
                                        fontSize: width * 0.027,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -width * 0.013,
                top: -width * 0.013,
                child: Container(
                    decoration: BoxDecoration(
                        color: Constant
                            .cardColors[index % Constant.cardColors.length][0],
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/icons/check icon.svg',
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
