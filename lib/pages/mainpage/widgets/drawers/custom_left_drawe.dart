import 'package:expense_app/constants/const.dart';
import 'package:expense_app/pages/mainpage/widgets/payment_notification.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CustomLeftDrawer extends StatefulWidget {
  const CustomLeftDrawer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<CustomLeftDrawer> createState() => _CustomLeftDrawerState();
}

class _CustomLeftDrawerState extends State<CustomLeftDrawer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: widget.height * 0.90,
          width: widget.width * 0.75,
          child: Drawer(
            backgroundColor: Constant.mainPageDrawerbackground,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ':اعلانات',
                        style: TextStyle(
                            fontFamily: 'vazir',
                            color: Colors.white,
                            fontSize: widget.width * 0.05,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: widget.width * 0.03,
                      ),
                      SvgPicture.asset(
                        value.notificationPayemnts.isEmpty
                            ? 'assets/icons/notification icon off.svg'
                            : 'assets/icons/notification icon.svg',
                        height: widget.width * 0.07,
                        width: widget.width * 0.07,
                      )
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.80,
                    child: value.notificationPayemnts.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width,
                                child: LottieBuilder.asset(
                                  'assets/animations/empty_placeholder.json',
                                ),
                              ),
                              Text('!آیتمی برای نمایش وجود ندارد',
                                  style: TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * 0.045))
                            ],
                          )
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: widget.width * 0.02,
                              );
                            },
                            itemBuilder: (context, index) {
                              return PaymentNotification(
                                index: index,
                                payment: value.notificationPayemnts[index]!,
                              );
                            },
                            itemCount: value.notificationPayemnts.length,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
