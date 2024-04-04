import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata_sathi/services/helpers/data_helper.dart';
import 'package:khata_sathi/utils/routes.dart';
import 'package:khata_sathi/views/screens/add_page.dart';
import 'package:khata_sathi/views/screens/edit_page.dart';
import 'package:khata_sathi/views/screens/splash_page.dart';
import 'package:khata_sathi/views/screens/transactions_page.dart';
import 'package:provider/provider.dart';

import 'controllers/page_controller.dart';
import 'controllers/transaction_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataHelper.dataHelper.initDataBase();
  log("DB Created");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Pagecontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: (Provider.of<Pagecontroller>(context).isDark)
            ? Brightness.dark
            : Brightness.light,
        colorSchemeSeed: (Provider.of<Pagecontroller>(context).isDark)
            ? CupertinoColors.systemIndigo
            : CupertinoColors.activeBlue,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        MyRoutes.transaction: (context) => const TransactionsPage(),
        MyRoutes.add: (context) => const AddPage(),
        MyRoutes.edit: (context) => const EditPage(),
      },
    );
  }
}
