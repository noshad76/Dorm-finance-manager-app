import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expense_app/constants/base_url.dart';
import 'package:expense_app/database/app_database.dart';
import 'package:expense_app/models/debts_model.dart';
import 'package:expense_app/models/payment_model.dart';
import 'package:expense_app/models/user_model.dart';
import 'package:flutter/material.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 7),
    receiveTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 7),
  ),
);
Future<bool> sendPayment(Payment payment) async {
  Response resp = await dio.post('$baseUrl/new-payment',
      data: payment.tojson(),
      options: Options(headers: {
        "APP-X-TOKEN": await TokenBox.getToken(),
        HttpHeaders.contentTypeHeader: "application/json",
      }));

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  return json['ok'];
}

Future<bool> login(String username, String password) async {
  Response resp = await dio.post('$baseUrl/login',
      data: {'username': username, 'password': password},
      options: Options(
          headers: {HttpHeaders.contentTypeHeader: "application/json"}));

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  if (json['ok'] == true) {
    TokenBox.saveToken(json['token']);
    return json['ok'];
  }
  return json['ok'];
}

Future<User?> requestLoginStatus(String token) async {
  Response resp = await dio.get('$baseUrl/me',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'APP-X-TOKEN': token,
      }));

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  if (json['ok'] == true) {
    return User.fromjson(json['user']);
  }
  return null;
}

Future<List<User?>> getContacts(String token) async {
  Response resp = await dio.get(
    '$baseUrl/list-users',
    options: Options(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'APP-X-TOKEN': token,
      },
    ),
  );

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  List<User> contacts = List.castFrom(json['users']).map((e) {
    return User.fromjson(e);
  }).toList();

  return contacts;
}

Future<List<Payment?>> getPayments(String? token) async {
  Response resp = await dio.get(
    '$baseUrl/my-payments',
    options: Options(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'APP-X-TOKEN': token,
      },
    ),
  );

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  List<Payment> payments = List.castFrom(json['payments']).map((e) {
    return Payment.fromjson(e);
  }).toList();
  return payments;
}

Future<List<Payment?>> getAllPayments(String? token) async {
  Response resp = await dio.get(
    '$baseUrl/all-payments',
    options: Options(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'APP-X-TOKEN': token,
      },
    ),
  );

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  List<Payment> payments = List.castFrom(json['payments']).map((e) {
    return Payment.fromjson(e);
  }).toList();
  return payments;
}

Future<List<Debts?>> getAllDebts(String? token) async {
  Response resp = await dio.get(
    '$baseUrl/my-debts',
    options: Options(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'APP-X-TOKEN': token,
      },
    ),
  );

  Map<String, dynamic> json = jsonDecode(resp.toString());
  debugPrint(json.toString());

  List<Debts> debts = List.castFrom(json['debts']).map((e) {
    return Debts.fromJson(e);
  }).toList();
  return debts;
}
