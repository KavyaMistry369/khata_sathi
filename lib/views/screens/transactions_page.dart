import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:khata_sathi/controllers/page_controller.dart';
import 'package:khata_sathi/controllers/transaction_controller.dart';
import 'package:khata_sathi/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/transaction_model.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionController>(builder: (context, p, _) {
      Pagecontroller pro = Provider.of<Pagecontroller>(context);
      TransactionModel transactionModel = TransactionModel();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Transactions"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Filter"),
                      actions: [
                        Column(
                          children: [
                            RadioListTile(
                              title: const Text("all"),
                              value: filter.all,
                              groupValue: pro.radio,
                              onChanged: (filter? value) {
                                Provider.of<Pagecontroller>(context,
                                        listen: false)
                                    .changeFilter(val: value!);
                                p.getAllTransactions();
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: const Text("credit"),
                              value: filter.credit,
                              groupValue: pro.radio,
                              onChanged: (filter? value) {
                                Provider.of<Pagecontroller>(context,
                                        listen: false)
                                    .changeFilter(val: value!);
                                p.getFilterTransactions(type: value.name);
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: const Text("debit"),
                              value: filter.debit,
                              groupValue: pro.radio,
                              onChanged: (filter? value) {
                                Provider.of<Pagecontroller>(context,
                                        listen: false)
                                    .changeFilter(val: value!);
                                p.getFilterTransactions(type: value.name);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.filter_alt_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: (p.allTransactions.isNotEmpty)
              ? ListView.builder(
                  itemCount: (transactionModel.type == filter.all.name)
                      ? p.allFilterTransactions.length
                      : p.allTransactions.length,
                  itemBuilder: (context, index) {
                    TransactionModel transactionmodel =
                        (transactionModel.type == filter.all.name)
                            ? p.allFilterTransactions[index]
                            : p.allTransactions[index];



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
                                            p.deleteTransaction(
                                                id: transactionModel.id!);
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
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
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
                                  path: transactionModel.phone,
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
                            leading: (transactionmodel.type == "credit")
                                ? const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.green,
                                  )
                                : const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.red,
                                  ),
                          ),
                        ),
                      ),
                    );
                  })
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: (pro.isDark)?Image.asset("lib/views/assets/1.png",width: 300,):Image.asset("lib/views/assets/2.png",width: 300,),
                    ),
                  Text("Add Your Khata",style: TextStyle(fontSize: 25),),
                ],
              )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(MyRoutes.add);
          },
          label: const Text("Add"),
          icon: const Icon(Icons.add),
        ),
      );
    });
  }
}
