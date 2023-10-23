class User {
  late int id;
  late String name;
  late String picture;
  late String cardNumber;

  User(
      {required this.id,
      required this.name,
      required this.picture,
      required this.cardNumber});

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      cardNumber: json['card'],
    );
  }
}
