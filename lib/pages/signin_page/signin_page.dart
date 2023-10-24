import 'package:dio/dio.dart';
import 'package:expense_app/api/api_service.dart';
import 'package:expense_app/constants/const.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/models/user_model.dart';
import 'package:expense_app/pages/mainpage/main_page.dart';

import 'package:expense_app/pages/signin_page/widgets/circle_background.dart';
import 'package:expense_app/pages/signin_page/widgets/sign_fields.dart';
import 'package:expense_app/state/login_page_provider.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<LogInPageProvider>(
      builder: (context, mainpageprovider, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                color: Constant.loginBackground1,
              ),
              Stack(
                children: [
                  BackgroundCircles(
                    left: -width * 0.25,
                    top: width * 0.125,
                  ),
                  BackgroundCircles(
                    right: -width * 0.25,
                    top: -width * 0.38,
                  ),
                  BackgroundCircles(
                    right: -width * 0.38,
                    top: height * 0.3,
                  ),
                  BackgroundCircles(
                    left: -width * 0.38,
                    top: height * 0.52,
                  ),
                  BackgroundCircles(
                    top: height * 0.8,
                    right: -width * 0.25,
                  ),
                ],
              ),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.125),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: width * 0.19),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.32,
                              width: height * 0.32,
                              decoration: BoxDecoration(
                                color: Constant.loginTextField,
                                borderRadius:
                                    BorderRadius.circular(width * 0.1),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, width * 0.01),
                                    blurStyle: BlurStyle.solid,
                                    color: Colors.black,
                                    blurRadius: width * 0.018,
                                    spreadRadius: -width * 0.011,
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                r'assets/icons/Dormnance icon.svg',
                                height: width * 0.38,
                                colorFilter: const ColorFilter.mode(
                                    Constant.cartIcon, BlendMode.srcIn),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                            ),
                            const Formfield(
                              hint: 'نام کاربری',
                              icon: 'assets/icons/🦆 icon _profile_.svg',
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            const Formfield(
                              hint: 'رمز عبور',
                              icon: 'assets/icons/🦆 icon _key_.svg',
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            LoginButton(formKey: formKey),
                            const Spacer(),
                            Container(
                              alignment: Alignment.center,
                              height: height * 0.06,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                color: Constant.loginTextField,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(height * 0.055),
                                  topLeft: Radius.circular(height * 0.055),
                                ),
                              ),
                              child: Text(
                                'Psycho Lab',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<LogInPageProvider>(
      builder: (context, mainpageprovider, child) {
        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.1),
              ),
            ),
            minimumSize: MaterialStatePropertyAll(
              Size(width, height * 0.075),
            ),
            backgroundColor:
                const MaterialStatePropertyAll(Constant.loginbutton),
          ),
          onPressed: () async {
            try {
              if (formKey.currentState!.validate()) {
                if (mainpageprovider.isLoadinglogin == false) {
                  mainpageprovider.changeisLoadinglogin();
                  if (await login(mainpageprovider.mainPageUserName,
                      mainpageprovider.mainPagePassword)) {
                    if (!context.mounted) return;
                    mainpageprovider.changeisLoadinglogin();
                    String? token = await TokenBox.getToken();
                    User? user = await requestLoginStatus(token!);
                    if (!context.mounted) return;
                    if (user == null) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: "مشکل در اتصال به سرور",
                        ),
                      );
                    } else {
                      Provider.of<MainPageProvider>(context, listen: false)
                          .setMainUserData(
                              userName: user.name,
                              pictureUrl: user.picture,
                              userid: user.id);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainPage();
                          },
                        ),
                      );
                    }
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          'نام کاربری و رمز عبور اشتباه است',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.025,
                          ),
                        ),
                        onVisible: () {
                          mainpageprovider.changeisSnackbarPoped();
                        },
                        backgroundColor: Constant.loginbutton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(height * 0.075),
                            topLeft: Radius.circular(height * 0.075),
                          ),
                        ),
                      ),
                    );
                    mainpageprovider.changeisLoadinglogin();
                  }
                }
              } else if (mainpageprovider.isSnackbarPoped) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      'نام کاربری و رمز عبور را وارد کنید',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.025,
                      ),
                    ),
                    onVisible: () {
                      mainpageprovider.changeisSnackbarPoped();
                    },
                    backgroundColor: Constant.loginTextField,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(height * 0.075),
                            topLeft: Radius.circular(height * 0.075))),
                  ),
                );
              }
            } on DioException catch (e) {
              debugPrint(e.toString());
              if (e.type == DioExceptionType.connectionTimeout ||
                  e.type == DioExceptionType.receiveTimeout ||
                  e.type == DioExceptionType.sendTimeout ||
                  e.type == DioExceptionType.connectionError) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                      message: "اتصال خود را بررسی کنید"),
                  displayDuration: const Duration(seconds: 2),
                );
              }
              mainpageprovider.changeisLoadinglogin();
            }
          },
          child: mainpageprovider.isLoadinglogin
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  'ورود',
                  style: TextStyle(
                    fontFamily: 'vazir',
                    color: Colors.white,
                    fontSize: height * 0.026,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      },
    );
  }
}
