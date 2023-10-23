import 'package:expense_app/models/user_model.dart';

class Debts {
  int price;
  User user;
  Debts({
    required this.price,
    required this.user,
  });
  factory Debts.fromJson(Map<String, dynamic> json) {
    return Debts(
      price: json['amount'].round(),
      user: User.fromjson(json['to']),
    );
  }
}
