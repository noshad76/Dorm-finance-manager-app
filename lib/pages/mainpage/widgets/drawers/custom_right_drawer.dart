import 'package:expense_app/constants/const.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/pages/loadingPage/loading_page.dart';
import 'package:expense_app/pages/mainpage/main_page.dart';
import 'package:expense_app/pages/netPayments/net_payment_page.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomRightDrawer extends StatelessWidget {
  CustomRightDrawer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  final List<String> titles = [
    'صفحه اصلی',
    'پرداخت های خالص',
    'مخاطبین',
    'نمودار مصرف',
    'خروج از حساب'
  ];
  final List<String> icons = [
    'assets/icons/home icon.svg',
    'assets/icons/list icon.svg',
    'assets/icons/contact icon.svg',
    'assets/icons/chart icon.svg',
    'assets/icons/logout icon.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: height * 0.90,
          width: width * 0.75,
          child: Drawer(
            backgroundColor: Constant.mainPageDrawerbackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * 0.07),
                topLeft: Radius.circular(width * 0.07),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.06),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '! ${value.mainUsername}',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: width * 0.025,
                      ),
                      CircleAvatar(
                        radius: width * 0.065,
                        backgroundImage:
                            const AssetImage('assets/images/1.jpg'),
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.07),
                  SizedBox(
                    height: height * 0.70,
                    child: Column(
                      children: [
                        MainMenuTiles(
                          titles: titles[0],
                          icons: icons[0],
                          index: 0,
                          onTap: () {
                            if (value.menuIndex != 0) {
                              value.changeMenuIndex(0);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const MainPage();
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: width * 0.055,
                        ),
                        MainMenuTiles(
                          titles: titles[1],
                          icons: icons[1],
                          index: 1,
                          onTap: () {
                            value.changeMenuIndex(1);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const NetPaymentsPage();
                              },
                            ));
                          },
                        ),
                        SizedBox(
                          height: width * 0.055,
                        ),
                        MainMenuTiles(
                          titles: titles[2],
                          icons: icons[2],
                          index: 2,
                          onTap: () {
                            value.changeMenuIndex(2);
                          },
                        ),
                        SizedBox(
                          height: width * 0.055,
                        ),
                        MainMenuTiles(
                          titles: titles[3],
                          icons: icons[3],
                          index: 3,
                          onTap: () {
                            value.changeMenuIndex(3);
                          },
                        ),
                        SizedBox(
                          height: width * 0.055,
                        ),
                        MainMenuTiles(
                          titles: titles[4],
                          icons: icons[4],
                          index: 4,
                          onTap: () async {
                            await TokenBox.removeToken();
                            value.changeMenuIndex(0);
                            if (!context.mounted) return;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const LoadingPage();
                              },
                            ));
                          },
                        ),
                      ],
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

class MainMenuTiles extends StatelessWidget {
  const MainMenuTiles({
    super.key,
    required this.onTap,
    required this.index,
    required this.titles,
    required this.icons,
  });
  final void Function()? onTap;
  final int index;
  final String titles;
  final String icons;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MainPageProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(width * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                titles,
                style: TextStyle(
                    fontFamily: 'vazir',
                    color: value.menuIndex == index
                        ? Colors.white
                        : Constant.sectionUnselected,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: width * 0.025,
              ),
              SvgPicture.asset(
                icons,
                colorFilter: ColorFilter.mode(
                  value.menuIndex == index ? Colors.white : Colors.white54,
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
