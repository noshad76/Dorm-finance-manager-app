import 'package:expense_app/api/api_service.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/models/payment_model.dart';
import 'package:expense_app/models/totals_model.dart';
import 'package:expense_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MainPageProvider extends ChangeNotifier {
  int secetionIndex = 1;

  void changeSectionIndex(int index) {
    secetionIndex = index;
    notifyListeners();
  }

  int selectedCardIndex = 0;
  void changeselectedCardIndex(int index) {
    selectedCardIndex = index;
    notifyListeners();
  }

  int selectedTextbox = 0;

  void changeselectedTextbox(int index) {
    selectedCardIndex = index;
    notifyListeners();
  }

  Map<int, bool> cardAnimation = {
    0: true,
    1: false,
    2: false,
    3: false,
  };
  void changecardAnimation() {
    for (var i = 0; i < cardAnimation.length; i++) {
      if (selectedCardIndex == i) {
        cardAnimation[selectedCardIndex] = true;
      } else {
        cardAnimation[i] = false;
      }
    }
    notifyListeners();
  }

  void cardAnimationToFalse() {
    for (var i = 0; i < cardAnimation.length; i++) {
      if (selectedCardIndex == i) {
        continue;
      }
      cardAnimation[i] = false;
    }
    notifyListeners();
  }

  String? title;
  String? price;
  String? description;
  int? date;
  List<User> contacts = [];

  void addcontact(User user) {
    contacts.add(user);
    notifyListeners();
  }

  void removecontact(User user) {
    contacts = contacts.where((e) {
      return e.id != user.id;
    }).toList();
    notifyListeners();
  }

  void resetcontact() {
    contacts.clear();
    notifyListeners();
  }

  int menuIndex = 0;
  void changeMenuIndex(int index) {
    menuIndex = index;
    notifyListeners();
  }

  bool isLoadingAddPayment = false;

  changeisLoadingAddPaymentnTofalse() {
    isLoadingAddPayment = false;
    notifyListeners();
  }

  void changeisLoadingAddPaymentn() {
    isLoadingAddPayment = !isLoadingAddPayment;
    notifyListeners();
  }

  void resetPaymentValues() {
    title = null;
    price = null;
    description = null;
    date = null;
    contacts = [];
    isDateSelected = false;
    notifyListeners();
  }

  String? mainUsername;
  String? mainUserpictureUrl;
  int? mainUserid;
  void setMainUserData(
      {required userName, required pictureUrl, required userid}) {
    mainUsername = userName;
    mainUserpictureUrl = pictureUrl;
    mainUserid = userid;
    notifyListeners();
  }

  bool isDateSelected = false;
  void changeisDateSelectedToTrue() {
    isDateSelected = true;
    notifyListeners();
  }

  void changeisDateSelectedToFalse() {
    isDateSelected = false;
    notifyListeners();
  }

  bool isMainPagePullToRefresh = false;
  void changeMainPageisPullToRefreshToTrue() {
    isMainPagePullToRefresh = true;
    notifyListeners();
  }

  void changeMainPageisPullToRefreshToFalse() {
    isMainPagePullToRefresh = false;
    notifyListeners();
  }

  List<Payment?> notificationPayemnts = [];
  // Future<List<Payment?>> fillNotificationPayemnts() async {
  //   notificationPayemnts = await getPayments(await TokenBox.getToken());
  //   notifyListeners();
  //   return notificationPayemnts;
  // }

  List<Payment?> allPayemnts = [];
  // Future<List<Payment?>> fillallPayemnts() async {
  //   allPayemnts = await getPayments(await TokenBox.getToken());
  //   notifyListeners();
  //   return allPayemnts;
  // }
  TotalsModel? totalsModel;
  List<User?> savedContacts = [];
  Future refresh() async {
    try {
      notificationPayemnts = await getPayments(await TokenBox.getToken());
      allPayemnts = await getAllPayments(await TokenBox.getToken());
      totalsModel = await getTotals(await TokenBox.getToken());
      savedContacts = await getContacts(await TokenBox.getToken());
      savedContacts =
          savedContacts.where((element) => element!.id != mainUserid).toList();
      notifyListeners();
    } on Exception catch (_) {
      throw Exception("Error on server");
    }
  }

  bool isMainPageHaseExeption = false;
  void changeMainPageHaseExeptionToTrue() {
    isMainPageHaseExeption = true;
    notifyListeners();
  }

  void changeMainPageHaseExeptionToFalse() {
    isMainPageHaseExeption = false;
    notifyListeners();
  }

  String formatAmount(String price) {
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }

  void initDataAfterLogout() {
    changeselectedCardIndex(0);
    if (selectedCardIndex == 0) {
      cardAnimationToFalse();
    }
    // allPayemnts.clear();

    // notificationPayemnts.clear();

    notifyListeners();
  }

  String dateFormatter(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN}';
  }
}
