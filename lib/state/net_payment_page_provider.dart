import 'package:expense_app/api/api_service.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/models/debts_model.dart';
import 'package:flutter/material.dart';

class NetPaymentPageProvider extends ChangeNotifier {
  bool isNetPaymentPagePullToRefresh = false;
  void changeNetPaymentisPullToRefreshToTrue() {
    isNetPaymentPagePullToRefresh = true;
    notifyListeners();
  }

  void changeNetPaymentisPullToRefreshToFalse() {
    isNetPaymentPagePullToRefresh = false;
    notifyListeners();
  }

  List<Debts?> allDebts = [];
  Future refreshNetPayment() async {
    allDebts = await getAllDebts(await TokenBox.getToken());
  }

  bool isLoadingPayNetPayment = false;

  changeisLoadingPayNetPaymentTofalse() {
    isLoadingPayNetPayment = false;
    notifyListeners();
  }

  changeisLoadingPayNetPaymentToTrue() {
    isLoadingPayNetPayment = true;
    notifyListeners();
  }

  Future<bool> payNetPayment(int id) async {
    return await payDebt(await TokenBox.getToken(), id);
  }

  String formatCreditCardNumber(String input) {
    String formattedNumber =
        '${input.toString().substring(0, 4)} ${input.toString().substring(4, 8)} ${input.toString().substring(8, 12)} ${input.toString().substring(12)}';

    return formattedNumber;
  }

  bool isNetPaymentPageHaseExeption = false;
  void changeNetPaymentPageHaseExeptionToTrue() {
    isNetPaymentPageHaseExeption = true;
    notifyListeners();
  }

  void changeNetPaymentPageHaseExeptionToFalse() {
    isNetPaymentPageHaseExeption = false;

    notifyListeners();
  }

  initData() {
    allDebts.clear();
    notifyListeners();
  }
}
