import 'package:expense_app/models/user_model.dart';

class Payment {
  String title;
  int price;
  String description;
  int date;
  List<User> users;
  User? createdBy;
  Payment({
    required this.title,
    required this.price,
    required this.description,
    required this.date,
    required this.users,
    this.createdBy,
  });
  Map<String, dynamic> tojson() {
    return {
      'title': title,
      'date': date,
      'price': price,
      'description': description,
      'users': (users.map((e) => e.id).toList())
    };
  }

  factory Payment.fromjson(Map<String, dynamic> json) {
    return Payment(
      title: json['title'],
      price: json['price'],
      description: json['description'],
      date: json['date'],
      users: List.from(json['users']).map((e) {
        return User.fromjson(e);
      }).toList(),
      createdBy: User.fromjson(json['created_by']),
    );
  }
}
