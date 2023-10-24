import 'package:expense_app/pages/loadingPage/loading_page.dart';

import 'package:expense_app/state/login_page_provider.dart';
import 'package:expense_app/state/main_page_providor.dart';
import 'package:expense_app/state/net_payment_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LogInPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NetPaymentPageProvider(),
        )
      ],
      child: MaterialApp(
        theme: themeData.copyWith(
          colorScheme: themeData.colorScheme.copyWith(
            secondary: Colors.purple,
          ),
        ),
        title: 'Dormnance',
        debugShowCheckedModeBanner: false,
        home: const LoadingPage(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
