import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata_sathi/controllers/page_controller.dart';
import 'package:khata_sathi/views/screens/dashboard_page.dart';
import 'package:khata_sathi/views/screens/remainder_page.dart';
import 'package:khata_sathi/views/screens/transactions_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Pagecontroller>(
      builder: (context,provider,_) {
        return Scaffold(
          body: PageView(
            controller: provider.pageController,
            onPageChanged: (value) => provider.changePage(index: value),
            children: const [
              DashBoardPage(),
              TransactionsPage(),
              RemainderPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: CupertinoColors.activeBlue,
              type: BottomNavigationBarType.fixed,
              currentIndex: provider.initialIndex,
              onTap: (index) {
                provider.changePage(index: index);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.space_dashboard), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.attach_money), label: "Transaction"),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Remainder"),
              ]),
        );
      }
    );
  }
}
