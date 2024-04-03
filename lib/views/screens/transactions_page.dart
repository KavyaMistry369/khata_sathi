import 'package:flutter/material.dart';
import 'package:khata_sathi/controllers/transaction_controller.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_model.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionModel transactionModel = TransactionModel();

    return Consumer<TransactionController>(
      builder: (context,p,_) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: (p.getAllTransactions.isNotEmpty)?ListView.builder(
                itemCount: p.allTransactions.length,
                itemBuilder: (context, index) {

                  TransactionModel transactionModel =
                  p.getAllTransactions[index];

                  return Card(
                  child: ListTile(
                    title: Text("${transactionModel.name}"),
                    subtitle: Text("${transactionModel.remark}"),
                    trailing: (transactionModel.remark=="Credit")?const CircleAvatar(radius: 5,backgroundColor: Colors.green,):CircleAvatar(radius: 5,backgroundColor: Colors.red,),
                  ),
                );
      }):const Center(child: CircularProgressIndicator(),),
          ),
        );
      }
    );
  }
}
