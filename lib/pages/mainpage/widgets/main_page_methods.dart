import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:expense_app/api/api_service.dart';
import 'package:expense_app/constants/const.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/models/payment_model.dart';
import 'package:expense_app/models/user_model.dart';
import 'package:expense_app/pages/mainpage/widgets/custom_main_elevated_button.dart';
import 'package:expense_app/pages/mainpage/widgets/elevated_button.dart';
import 'package:expense_app/pages/mainpage/widgets/modal_text_field.dart';
import 'package:expense_app/pages/mainpage/widgets/sections.dart';
import 'package:expense_app/pages/mainpage/widgets/total_payment_items.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetimepickers/persian_datetimepickers.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MainPageMethods {
  static PersistentBottomSheetController<dynamic> totalsBottomSheet(
      BuildContext context, MainPageProvider mainPageProvider) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PersistentBottomSheetController<dynamic> controller = showBottomSheet(
      enableDrag: false,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Constant.totalsBackground,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: height * 0.045,
                      child: const Sections(
                        text: 'کلیه مخارج',
                        section: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      mainPageProvider.changeSectionIndex(1);
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
                    width: width * 0.07,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(width * 0.05),
                padding: EdgeInsets.all(width * 0.04),
                height: height * 0.83,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.05),
                    color: Constant.mainPageDrawerbackground),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TotalsPaymentItems(
                      backgroundImage: const AssetImage('assets/images/1.jpg'),
                      index: index,
                      payment: mainPageProvider.allPayemnts[index]!,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: width * 0.025,
                    );
                  },
                  itemCount: mainPageProvider.allPayemnts.length,
                ),
              )
            ],
          ),
        );
      },
    );
    controller.closed.then((value) {
      mainPageProvider.changeSectionIndex(1);
    });

    return controller;
  }

  static Future<dynamic> customshowModalBottomSheet(
      BuildContext context, RefreshController refreshController) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Jalali? jalaliDate;
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Consumer<MainPageProvider>(
          builder: (context, mainPageProvider, child) {
            return Container(
              padding: EdgeInsets.all(width * 0.06),
              height: height * 0.68 + MediaQuery.of(context).viewInsets.bottom,
              width: width,
              decoration: BoxDecoration(
                color: Constant.mainPageCardbackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.06),
                  topRight: Radius.circular(width * 0.06),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'افزودن خرید جدید',
                          style: TextStyle(
                              fontFamily: 'vazir',
                              color: Colors.white,
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Form(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          children: [
                            SizedBox(
                              height: width * 0.04,
                            ),
                            const ModalTextField(
                                hint: ' موضوع', isBig: false, index: 0),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            const ModalTextField(
                                hint: 'مبلغ', isBig: false, index: 1),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            const ModalTextField(
                                hint: 'توضیحات', isBig: true, index: 2),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedbuttonModal(
                                    onPressed: () async {
                                      customDialog(context);
                                    },
                                    text: mainPageProvider.contacts.isEmpty
                                        ? SvgPicture.asset(
                                            'assets/icons/person 1.svg')
                                        : SvgPicture.asset(
                                            'assets/icons/person 2.svg')),
                                ElevatedbuttonModal(
                                  onPressed: () async {
                                    final DateTime? date =
                                        await showPersianDatePicker(
                                      context: context,
                                    );

                                    if (!context.mounted) return;

                                    final TimeOfDay? time =
                                        await showPersianTimePicker(
                                      context: context,
                                    );
                                    if (date != null) {
                                      int a = ((date.millisecondsSinceEpoch ~/
                                              1000) +
                                          ((time!.hour * 60 * 60) +
                                              (time.minute * 60)));
                                      mainPageProvider.date = a;
                                      mainPageProvider
                                          .changeisDateSelectedToTrue();
                                      jalaliDate = unixTimestampToJalali(
                                          mainPageProvider.date!);
                                    }
                                  },
                                  text: Text(
                                    mainPageProvider.isDateSelected
                                        ? '${jalaliDate!.year}/${jalaliDate!.month}/${jalaliDate!.day}'
                                        : 'تاریخ',
                                    style: const TextStyle(
                                      fontFamily: 'vazir',
                                      color: Constant.loginTextfieldContent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            CustomMainElevatedButton(
                              onpressed: () async {
                                if (!context.mounted) return;

                                if (mainPageProvider.title == null ||
                                    mainPageProvider.price == null ||
                                    mainPageProvider.title!.isEmpty ||
                                    mainPageProvider.price!.isEmpty) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                      backgroundColor: Constant.loginTextField,
                                      message: "موضوع و قیمت را وارد کنید",
                                    ),
                                    displayDuration: const Duration(seconds: 2),
                                  );
                                } else if (mainPageProvider.contacts.isEmpty ||
                                    mainPageProvider.date == null) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                      backgroundColor: Constant.loginTextField,
                                      message:
                                          "مخاطبین و تاریخ انتخاب نشده است",
                                    ),
                                    displayDuration: const Duration(seconds: 2),
                                  );
                                } else {
                                  if (!mainPageProvider.isLoadingAddPayment) {
                                    mainPageProvider
                                        .changeisLoadingAddPaymentn();
                                    Payment payment = Payment(
                                      title: mainPageProvider.title!,
                                      price: int.parse(mainPageProvider.price!),
                                      description:
                                          mainPageProvider.description ?? '',
                                      date: mainPageProvider.date!,
                                      users: mainPageProvider.contacts,
                                    );
                                    bool isPaymentSent = false;
                                    String err = "";
                                    try {
                                      isPaymentSent =
                                          await sendPayment(payment);
                                    } on DioException catch (e) {
                                      if (e.type ==
                                              DioExceptionType
                                                  .connectionTimeout ||
                                          e.type ==
                                              DioExceptionType.receiveTimeout ||
                                          e.type ==
                                              DioExceptionType.sendTimeout) {
                                        err = 'TIME_OUT';
                                      }
                                    }
                                    if (isPaymentSent) {
                                      if (!context.mounted) return;
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.success(
                                          message: "خرید اضافه شد",
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        displayDuration:
                                            const Duration(seconds: 2),
                                      );
                                      refreshController.requestRefresh();
                                    } else {
                                      if (!context.mounted) return;
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                          message: (err == 'TIME_OUT')
                                              ? "اتصال خود را بررسی کنید"
                                              : "خرید اضافه نشد",
                                        ),
                                        displayDuration:
                                            const Duration(seconds: 2),
                                      );
                                    }
                                    mainPageProvider
                                        .changeisLoadingAddPaymentn();
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Jalali unixTimestampToJalali(int unixTimestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

    return dateTime.toJalali();
  }

  static Future<dynamic> customDialog(
    BuildContext context,
  ) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Consumer<MainPageProvider>(
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.all(width * 0.05),
                height: height * 0.55,
                width: width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.08),
                  border: Border.all(
                      color: Constant.loginBackground1, width: width * 0.01),
                  color: Constant.loginTextField,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: width * 0.08,
                          ),
                        ),
                        Text(
                          ':مخاطبین',
                          style: TextStyle(
                            fontFamily: 'vazir',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.025,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(width * 0.025),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2860),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: FutureBuilder(
                          future: Future<List<User?>>.sync(() async {
                            String? token = await TokenBox.getToken();
                            List<User?> contacts = [];
                            try {
                              contacts = await getContacts(token!);
                              contacts = contacts
                                  .where((element) =>
                                      (element!.id != value.mainUserid))
                                  .toList();
                            } on DioException catch (e) {
                              if (e.type ==
                                      DioExceptionType.connectionTimeout ||
                                  e.type == DioExceptionType.receiveTimeout ||
                                  e.type == DioExceptionType.sendTimeout ||
                                  e.type == DioExceptionType.connectionError) {
                                showTopSnackBar(
                                  // ignore: use_build_context_synchronously
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                      message: "اتصال خود را بررسی کنید"),
                                  displayDuration: const Duration(seconds: 2),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                throw Exception();
                              }
                            }
                            return contacts;
                          }),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: width * 0.02,
                                      );
                                    },
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.only(
                                              topRight:
                                                  Radius.circular(width * 0.5),
                                              bottomRight:
                                                  Radius.circular(width * 0.5),
                                              bottomLeft:
                                                  Radius.circular(width * 0.3),
                                              topLeft:
                                                  Radius.circular(width * 0.3)),
                                          onTap: () {
                                            if (value.contacts
                                                .map((e) => e.id)
                                                .toList()
                                                .contains(snapshot
                                                    .data![index]!.id)) {
                                              value.removecontact(
                                                  snapshot.data![index]!);
                                            } else {
                                              value.addcontact(
                                                  snapshot.data![index]!);
                                            }
                                            // debugPrint(
                                            //     '111111111111111111111111111111111111${value.contacts}');
                                            // debugPrint(
                                            //     '22222222222222222222222222222222222222${snapshot.data![index]!.id}');
                                            // debugPrint(
                                            //     '333333333333333333333333333333333333333333${value.contacts.contains(snapshot.data![index]!)}');
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              value.contacts
                                                      .map((e) => e.id)
                                                      .toList()
                                                      .contains(snapshot
                                                          .data![index]!.id)
                                                  ? SvgPicture.asset(
                                                      'assets/icons/checked.svg')
                                                  : SvgPicture.asset(
                                                      'assets/icons/unchecked.svg'),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot.data![index]!.name,
                                                    style: const TextStyle(
                                                        fontFamily: 'vazir',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.02,
                                                  ),
                                                  CircleAvatar(
                                                    radius: width * 0.07,
                                                    backgroundImage:
                                                        const AssetImage(
                                                      'assets/images/1.jpg',
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : snapshot.hasError
                                    ? const Text('')
                                    : SizedBox(
                                        width: width * 0.6,
                                        height: width * 0.6,
                                        child: Center(
                                          child: SizedBox(
                                            width: width * 0.2,
                                            height: width * 0.2,
                                            child:
                                                const CircularProgressIndicator(
                                                    color: Colors.white),
                                          ),
                                        ),
                                      );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Widget appbar(void Function()? onTap) {
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        double width = MediaQuery.of(context).size.width;
        return Row(
          children: [
            Text(
              '! ${value.mainUsername}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.05,
                  fontFamily: 'vazir',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: width * 0.009,
            ),
            Text(
              'سلام',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.048,
                  fontFamily: 'vazir',
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            CircleAvatar(
              radius: width * 0.065,
              backgroundImage: const AssetImage('assets/images/1.jpg'),
              backgroundColor: Colors.green,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(width * 0.1),
                    onTap: onTap),
              ),
            )
          ],
        );
      },
    );
  }
}
