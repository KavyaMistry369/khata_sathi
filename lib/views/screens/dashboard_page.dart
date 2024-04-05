import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khata_sathi/controllers/transaction_controller.dart';
import 'package:khata_sathi/models/transaction_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/page_controller.dart';
import '../../utils/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionController>(
      builder: (context,pro,_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            leading: Icon(Icons.drag_handle),
            actions: [
              IconButton(
                  onPressed: () {
                    Provider.of<Pagecontroller>(context, listen: false)
                        .changeTheme();
                  },
                  icon: (Provider.of<Pagecontroller>(context).isDark)
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode)),
            ],
          ),
          body: Padding(padding: EdgeInsets.all(16),child: Column(children: [
            Row(
              children: [
                Card(
                  color: Colors.green,
                  child: Container(
                    height: 150,
                    width: 180,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Credit",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                        Text("${pro.totalCreditAmount}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.red,
                  child: Container(
                    height: 150,
                    width: 180,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Debit",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                        Text("${pro.totalDebitAmount}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Text("Today's Debit",style: TextStyle(fontSize: 20),),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              width: 500,
              child: ListView.builder(
                itemCount: pro.allTodayDebit.length,
                itemBuilder: (context, index) {
                  TransactionModel transactionmodel = pro.allTodayDebit[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          title: const Text("Details"),
                          actions: [
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Name :- ${transactionmodel.name}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Remark :- ${transactionmodel.remark}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Amount :- ${transactionmodel.amount}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone :- ${transactionmodel.phone}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date :- ${transactionmodel.date!}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Time :- ${transactionmodel.time}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              MyRoutes.edit,
                                              arguments: index);
                                        },
                                        label: const Text("Edit"),
                                        icon: const Icon(Icons.edit),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          pro.deleteTransaction(
                                              id: transactionmodel.id!);
                                        },
                                        label: const Text("Delete"),
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Slidable(
                      endActionPane:   ActionPane(motion: const ScrollMotion(), children: [
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              await FlutterPhoneDirectCaller.callNumber(
                                  transactionmodel.phone!);
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () async {
                              Uri sms = Uri(
                                scheme: 'sms',
                                query:
                                "body=Dear ${transactionmodel.name}\n you don't give me your amount",
                                path: transactionmodel.phone,
                              );
                              await launchUrl(sms);
                            },
                            icon: const Icon(
                              Icons.messenger,
                              color: Colors.blueAccent,
                            ))
                      ]),
                      child: Card(
                        child: ListTile(
                          title: Text("${transactionmodel.name}"),
                          subtitle: Text("${transactionmodel.remark}"),
                          trailing: Text("${transactionmodel.amount}"),
                        ),
                      ),
                    ),
                  );
                },),
            )
          ],),),
        );
      }
    );
  }
}
