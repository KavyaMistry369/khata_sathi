import 'package:flutter/material.dart';
import 'package:khata_sathi/controllers/page_controller.dart';
import 'package:khata_sathi/views/screens/dashboard_page.dart';
import 'package:khata_sathi/views/screens/transactions_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Pagecontroller>(
      builder: (context,pro,_) {
        return Scaffold(
          body: PageView(
            controller: pro.pageController,
            onPageChanged: (i){
              pro.changePage(index: i);
            },
            children: [
              DashboardPage(),
              TransactionsPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (i){
              pro.changePage(index: i);
            },
              currentIndex: pro.initialIndex,
              items: [
            BottomNavigationBarItem(icon: const Icon(Icons.dashboard),label: "Dashboard"),
            BottomNavigationBarItem(icon: const Icon(Icons.attach_money),label: "Transaction"),
          ]),
        );
      }
    );
  }
}
