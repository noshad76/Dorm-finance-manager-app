import 'package:expense_app/pages/mainpage/widgets/drawers/custom_left_drawe.dart';
import 'package:expense_app/pages/mainpage/widgets/drawers/custom_right_drawer.dart';
import 'package:expense_app/pages/mainpage/widgets/main_page_methods.dart';
import 'package:expense_app/pages/mainpage/widgets/main_page_shimmer.dart';
import 'package:expense_app/pages/mainpage/widgets/payment_item.dart';
import 'package:flutter/material.dart';

import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import 'package:expense_app/constants/const.dart';

import 'package:expense_app/pages/mainpage/widgets/custom_main_elevated_button.dart';

import 'package:expense_app/pages/mainpage/widgets/sections.dart';
import 'package:expense_app/pages/mainpage/widgets/totals.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    try {
      Future.delayed(
        Duration.zero,
        () async {
          Provider.of<MainPageProvider>(context, listen: false)
              .changeMainPageHaseExeptionToTrue();
          Provider.of<MainPageProvider>(context, listen: false)
              .changeMainPageisPullToRefreshToTrue();
          await Provider.of<MainPageProvider>(context, listen: false).refresh();
          if (!context.mounted) return;

          Provider.of<MainPageProvider>(context, listen: false)
              .changeMainPageisPullToRefreshToFalse();
        },
      );
    } on Exception catch (_) {
      Provider.of<MainPageProvider>(context, listen: false)
          .changeMainPageHaseExeptionToTrue();
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "اینترنت خود را بررسی کنید",
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _key,
      drawer: CustomLeftDrawer(height: height, width: width),
      endDrawer: CustomRightDrawer(height: height, width: width),
      resizeToAvoidBottomInset: false,
      backgroundColor: Constant.loginBackground1,
      body: Consumer<MainPageProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.035),
              child: SmartRefresher(
                enablePullUp: false,
                controller: refreshController,
                onRefresh: () async {
                  try {
                    value.changeMainPageHaseExeptionToTrue();
                    Provider.of<MainPageProvider>(context, listen: false)
                        .changeMainPageisPullToRefreshToTrue();
                    await Provider.of<MainPageProvider>(context, listen: false)
                        .refresh();
                    if (!context.mounted) return;

                    Provider.of<MainPageProvider>(context, listen: false)
                        .changeMainPageisPullToRefreshToFalse();
                  } on Exception catch (_) {
                    refreshController.refreshFailed();
                    value.changeMainPageHaseExeptionToFalse();
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "اینترنت خود را بررسی کنید",
                      ),
                    );
                  }

                  refreshController.refreshCompleted();
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: !value.isMainPageHaseExeption ||
                                      value.isMainPagePullToRefresh
                                  ? () {}
                                  : () {
                                      _key.currentState!.openDrawer();
                                    },
                              borderRadius:
                                  BorderRadius.circular(width * 0.025),
                              child: SvgPicture.asset(
                                'assets/icons/notification icon.svg',
                                height: width * 0.07,
                                width: width * 0.07,
                              )),
                          MainPageMethods.appbar(
                            !value.isMainPageHaseExeption ||
                                    value.isMainPagePullToRefresh
                                ? () {}
                                : () {
                                    _key.currentState!.openEndDrawer();
                                  },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Totals(
                          icon: SvgPicture.asset(
                            'assets/icons/🦆 icon _money send_.svg',
                            height: height * 0.045,
                          ),
                          price: '18,500',
                          text: 'کلیه بدهی ها',
                        ),
                        SizedBox(
                          width: height * 0.02,
                        ),
                        Totals(
                          icon: SvgPicture.asset(
                              'assets/icons/🦆 icon _money resive_.svg',
                              height: height * 0.04),
                          price: '18,500',
                          text: 'کلیه خرج ها',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: value.allPayemnts.isEmpty ||
                                    !value.isMainPageHaseExeption ||
                                    value.isMainPagePullToRefresh
                                ? () {}
                                : () {
                                    value.changeSectionIndex(2);
                                    MainPageMethods.totalsBottomSheet(
                                        context, value);
                                  },
                            child: SizedBox(
                              height: height * 0.05,
                              child: const Sections(
                                text: 'کلیه مخارج',
                                section: 2,
                              ),
                            )),
                        SizedBox(
                          width: height * 0.04,
                        ),
                        GestureDetector(
                          onTap: () {
                            value.changeSectionIndex(1);
                          },
                          child: SizedBox(
                            height: height * 0.05,
                            child: const Sections(
                              section: 1,
                              text: 'آخرین مخارج',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.045,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: height * 0.02, vertical: height * 0.022),
                      decoration: BoxDecoration(
                        color: Constant.mainPageCardbackground,
                        borderRadius: BorderRadius.circular(height * 0.03),
                      ),
                      height: height * 0.525,
                      child: Column(
                        children: [
                          !value.isMainPageHaseExeption
                              ? SizedBox(
                                  width: width,
                                  height: height * 0.4,
                                  child: LottieBuilder.asset(
                                      'assets/animations/conection_lost.json'),
                                )
                              : value.isMainPagePullToRefresh
                                  ? MainPageShimmer(
                                      height: height, width: width)
                                  : value.allPayemnts.isEmpty
                                      ? SizedBox(
                                          height: 300,
                                          width: 400,
                                          child: LottieBuilder.asset(
                                              'assets/animations/empty_placeholder.json'),
                                        )
                                      : SizedBox(
                                          height: height * 0.4,
                                          child: ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: height * 0.006,
                                              );
                                            },
                                            itemCount:
                                                value.allPayemnts.length > 4
                                                    ? 4
                                                    : value.allPayemnts.length,
                                            itemBuilder: (context, index) {
                                              return PaymentItem(
                                                payment:
                                                    value.allPayemnts[index]!,
                                                backgroundImage:
                                                    const AssetImage(
                                                        'assets/images/1.jpg'),
                                                index: index,
                                              );
                                            },
                                          ),
                                        ),
                          CustomMainElevatedButton(
                            onpressed: () async {
                              await MainPageMethods.customshowModalBottomSheet(
                                  context);
                              value.resetPaymentValues();
                              value.changeisLoadingAddPaymentnTofalse();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
