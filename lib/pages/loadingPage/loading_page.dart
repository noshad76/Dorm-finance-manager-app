import 'package:expense_app/api/api_service.dart';
import 'package:expense_app/constants/const.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/models/user_model.dart';
import 'package:expense_app/pages/mainpage/main_page.dart';
import 'package:expense_app/pages/signin_page/signin_page.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future<bool> checkinternetConection() async {
    setState(() {
      isInprogress = true;
    });
    bool result = await InternetConnectionChecker().hasConnection;
    setState(() {
      isInprogress = false;
      isInternetConected = result;
    });

    return result;
  }

  void loginRequest() {
    TokenBox.getToken().then(
      (value) {
        token = value;
        if (token == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const SignIn();
              },
            ),
          );
        } else {
          requestLoginStatus(token!).then((value) async {
            user = value;

            if (user == null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const SignIn();
                  },
                ),
              );
            } else {
              Provider.of<MainPageProvider>(context, listen: false)
                  .setMainUserData(
                      userName: user!.name,
                      pictureUrl: user!.picture,
                      userid: user!.id);
              await Provider.of<MainPageProvider>(context, listen: false)
                  .refresh();
              if (!context.mounted)return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const MainPage();
                  },
                ),
              );
            }
          }).onError((error, stackTrace) {
            setState(() {
              isInprogress = false;
              isInternetConected = false;
            });
          });
        }
      },
    );
  }

  User? user;
  String? token;
  bool isInternetConected = false;
  bool isInprogress = false;

  @override
  void initState() {
    checkinternetConection().then((value) {
      if (value) {
        loginRequest();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constant.loginBackground1,
      body: Center(
        child: (isInprogress || isInternetConected)
            ? SizedBox(
                height: width * 0.35,
                width: width * 0.35,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset(
                    'assets/animations/conection_lost.json',
                    height: height * 0.4,
                    width: height * 0.4,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Text(
                    'اتصال خود را بررسی کنید',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(width * 0.01),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(width * 0.1)))),
                      minimumSize: MaterialStatePropertyAll(
                          Size(width * 0.52, height * 0.07)),
                      backgroundColor: const MaterialStatePropertyAll(
                          Constant.loginTextField),
                    ),
                    onPressed: () {
                      checkinternetConection().then((value) {
                        if (value) {
                          loginRequest();
                        }
                      });
                    },
                    child: Text(
                      'تلاش مجدد',
                      style: TextStyle(
                          fontSize: width * 0.05, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  )
                ],
              ),
      ),
    );
  }
}
