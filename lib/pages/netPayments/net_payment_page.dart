import 'package:dio/dio.dart';
import 'package:expense_app/constants/const.dart';
import 'package:expense_app/pages/mainpage/main_page.dart';
import 'package:expense_app/pages/mainpage/widgets/drawers/custom_right_drawer.dart';
import 'package:expense_app/pages/mainpage/widgets/main_page_methods.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:expense_app/state/net_payment_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NetPaymentsPage extends StatefulWidget {
  const NetPaymentsPage({super.key});

  @override
  State<NetPaymentsPage> createState() => _NetPaymentsPageState();
}

class _NetPaymentsPageState extends State<NetPaymentsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    try {
      Future.delayed(
        Duration.zero,
        () async {
          Provider.of<NetPaymentPageProvider>(context, listen: false)
              .changeNetPaymentPageHaseExeptionToFalse();
          Provider.of<NetPaymentPageProvider>(context, listen: false)
              .changeNetPaymentisPullToRefreshToTrue();
          await Provider.of<NetPaymentPageProvider>(context, listen: false)
              .refreshNetPayment();
          if (mounted) {
            Provider.of<NetPaymentPageProvider>(context, listen: false)
                .changeNetPaymentisPullToRefreshToFalse();
          }
        },
      );
    } on Exception catch (_) {
      refreshController.refreshFailed();
      Provider.of<NetPaymentPageProvider>(context, listen: false)
          .changeNetPaymentPageHaseExeptionToTrue();

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
      endDrawer: CustomRightDrawer(height: height, width: width),
      resizeToAvoidBottomInset: false,
      backgroundColor: Constant.loginBackground1,
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<MainPageProvider>(context).changeMenuIndex(0);
          Navigator.of(context).pop();
          return true;
        },
        child: Consumer<NetPaymentPageProvider>(
          builder: (context, value, child) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                child: SmartRefresher(
                  enablePullUp: false,
                  controller: refreshController,
                  onRefresh: () async {
                    try {
                      value.changeNetPaymentPageHaseExeptionToFalse();

                      Provider.of<NetPaymentPageProvider>(context,
                              listen: false)
                          .changeNetPaymentisPullToRefreshToTrue();
                      await Provider.of<NetPaymentPageProvider>(context,
                              listen: false)
                          .refreshNetPayment();
                      if (!context.mounted) return;

                      Provider.of<NetPaymentPageProvider>(context,
                              listen: false)
                          .changeNetPaymentisPullToRefreshToFalse();
                    } on DioException catch (_) {
                      value.changeNetPaymentPageHaseExeptionToTrue();

                      refreshController.refreshFailed();

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
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  _key.currentState!.openDrawer();
                                },
                                borderRadius:
                                    BorderRadius.circular(width * 0.025),
                                child: IconButton(
                                    onPressed: () {
                                      try {
                                        Future.delayed(
                                          Duration.zero,
                                          () async {
                                            Provider.of<MainPageProvider>(
                                                    context,
                                                    listen: false)
                                                .changeMainPageHaseExeptionToTrue();
                                            Provider.of<MainPageProvider>(
                                                    context,
                                                    listen: false)
                                                .changeMainPageisPullToRefreshToTrue();
                                            await Provider.of<MainPageProvider>(
                                                    context,
                                                    listen: false)
                                                .refresh();
                                            if (!context.mounted) return;

                                            Provider.of<MainPageProvider>(
                                                    context,
                                                    listen: false)
                                                .changeMainPageisPullToRefreshToFalse();
                                          },
                                        );
                                      } on Exception catch (_) {
                                        Provider.of<MainPageProvider>(context,
                                                listen: false)
                                            .changeMainPageHaseExeptionToTrue();
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.error(
                                            message:
                                                "اینترنت خود را بررسی کنید",
                                          ),
                                        );
                                      }
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          Future.delayed(
                                            Duration.zero,
                                            () {
                                              Provider.of<MainPageProvider>(
                                                      context,
                                                      listen: false)
                                                  .changeMenuIndex(0);
                                            },
                                          );

                                          return const MainPage();
                                        },
                                      ));
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                      size: width * 0.08,
                                    ))),
                            MainPageMethods.appbar(
                              !value.isNetPaymentPageHaseExeption ||
                                      value.isNetPaymentPagePullToRefresh
                                  ? () {}
                                  : () {
                                      _key.currentState!.openEndDrawer();
                                    },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      value.isNetPaymentPageHaseExeption
                          ? LottieBuilder.asset(
                              'assets/animations/conection_lost.json')
                          : SizedBox(
                              height: height * 0.8,
                              child: value.isNetPaymentPagePullToRefresh
                                  ? SizedBox(
                                      height: height * 0.4,
                                      child: ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: height * 0.015,
                                          );
                                        },
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            alignment: Alignment.centerRight,
                                            padding:
                                                EdgeInsets.all(width * 0.04),
                                            height: height * 0.22,
                                            width: width * 0.7,
                                            decoration: BoxDecoration(
                                                color: Constant.loginTextField,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color:
                                                        Constant.paymentBorders,
                                                    width: 2)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height: width * 0.03,
                                                ),
                                                Shimmer.fromColors(
                                                    baseColor: Constant
                                                        .sectionUnselected,
                                                    highlightColor: Constant
                                                        .mainPageCardbackground,
                                                    child: Container(
                                                      width: width * 0.3,
                                                      height: width * 0.055,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width *
                                                                        0.07),
                                                        color: Constant
                                                            .loginTextField,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: width * 0.03,
                                                ),
                                                Shimmer.fromColors(
                                                    baseColor: Constant
                                                        .sectionUnselected,
                                                    highlightColor: Constant
                                                        .mainPageCardbackground,
                                                    child: Container(
                                                      width: width * 0.35,
                                                      height: width * 0.055,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width *
                                                                        0.07),
                                                        color: Constant
                                                            .loginTextField,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: width * 0.03,
                                                ),
                                                Shimmer.fromColors(
                                                    baseColor: Constant
                                                        .sectionUnselected,
                                                    highlightColor: Constant
                                                        .mainPageCardbackground,
                                                    child: Container(
                                                      width: width * 0.5,
                                                      height: width * 0.055,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    width *
                                                                        0.07),
                                                        color: Constant
                                                            .loginTextField,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: width * 0.03,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Shimmer.fromColors(
                                                      baseColor: Constant
                                                          .sectionUnselected,
                                                      highlightColor: Constant
                                                          .mainPageCardbackground,
                                                      child: Container(
                                                        height: width * 0.07,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      width *
                                                                          0.07),
                                                          color: Constant
                                                              .loginTextField,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : value.allDebts.isEmpty
                                      ? Column(
                                          children: [
                                            LottieBuilder.asset(
                                                'assets/animations/empty_placeholder.json'),
                                            Text('!آیتمی برای پرداخت نداریم',
                                                style: TextStyle(
                                                    fontFamily: 'vazir',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.045))
                                          ],
                                        )
                                      : ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Consumer<MainPageProvider>(
                                              builder:
                                                  (context, value2, child) {
                                                return Container(
                                                  padding: EdgeInsets.all(
                                                      width * 0.04),
                                                  height: height * 0.225,
                                                  width: width * 0.7,
                                                  decoration: BoxDecoration(
                                                      color: Constant
                                                          .loginTextField,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width * 0.08),
                                                      border: Border.all(
                                                          color: Constant
                                                              .paymentBorders,
                                                          width: 2)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'بدهی به ${value.allDebts[index]!.user.name} ',
                                                        style: TextStyle(
                                                            fontFamily: 'vazir',
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.045,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            ' تومان ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'vazir',
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    width *
                                                                        0.045),
                                                          ),
                                                          Text(
                                                            value2.formatAmount(
                                                                value
                                                                    .allDebts[
                                                                        index]!
                                                                    .price
                                                                    .toString()),
                                                            style: GoogleFonts.inter(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.045,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          Text(
                                                            ':مبلغ بدهی ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'vazir',
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    width *
                                                                        0.045),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            value
                                                                .formatCreditCardNumber(
                                                              value
                                                                  .allDebts[
                                                                      index]!
                                                                  .user
                                                                  .cardNumber,
                                                            ),
                                                            style: GoogleFonts.inter(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.045,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          IconButton(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  width * 0.09,
                                                            ),
                                                            splashRadius: 1,
                                                            onPressed: () {
                                                              Clipboard.setData(
                                                                  ClipboardData(
                                                                      text: value
                                                                          .allDebts[
                                                                              index]!
                                                                          .user
                                                                          .cardNumber));
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      backgroundColor:
                                                                          Constant
                                                                              .loginbutton,
                                                                      content:
                                                                          Text(
                                                                        'شماره کارت با موفقیت کپی شد',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'vazir',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize: width * 0.04),
                                                                        textDirection:
                                                                            TextDirection.rtl,
                                                                      )));
                                                            },
                                                            icon: const Icon(
                                                              Icons.copy,
                                                              color: Constant
                                                                  .loginbutton,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          debugPrint(
                                                              "Clicked on : ${value.allDebts[index]!.user.username}");
                                                          customNetPaymentDialog(
                                                              context,
                                                              height,
                                                              width);
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              const MaterialStatePropertyAll(
                                                                  Constant
                                                                      .loginbutton),
                                                          shape:
                                                              MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                          ),
                                                          minimumSize:
                                                              const MaterialStatePropertyAll(
                                                            Size(
                                                                double.infinity,
                                                                40),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'پرداخت',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'vazir',
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: width *
                                                                  0.045),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: height * 0.015,
                                            );
                                          },
                                          itemCount: value.allDebts.length),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> customNetPaymentDialog(
      BuildContext context, double height, double width) {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<NetPaymentPageProvider>(
          builder: (context, value, child) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Constant.loginTextField),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'آیا با ثبت پرداخت موافقید؟',
                      style: TextStyle(
                          fontFamily: 'vazir',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.045),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: value.isLoadingPayNetPayment
                              ? () {}
                              : () async {
                                  value.changeisLoadingPayNetPaymentToTrue();
                                  await value.payNetPayment();
                                  value.changeisLoadingPayNetPaymentTofalse();
                                  if (!context.mounted) return;
                                  Navigator.of(context).pop();
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.success(
                                      message: "پرداخت با موفقیت انجام شد",
                                    ),
                                  );
                                },
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Constant.loginbutton),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            minimumSize: MaterialStatePropertyAll(
                              Size(width * 0.25, height * 0.04),
                            ),
                          ),
                          child: value.isLoadingPayNetPayment
                              ? SizedBox(
                                  height: height * 0.02,
                                  width: height * 0.02,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "بله",
                                  style: TextStyle(
                                      fontFamily: 'vazir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * 0.04),
                                ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Constant.loginBackground2),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            minimumSize: MaterialStatePropertyAll(
                              Size(width * 0.25, height * 0.04),
                            ),
                          ),
                          child: Text(
                            "خیر",
                            style: TextStyle(
                                fontFamily: 'vazir',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
