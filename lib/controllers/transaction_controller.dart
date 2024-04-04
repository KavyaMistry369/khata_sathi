import 'package:flutter/material.dart';
import 'package:khata_sathi/services/helpers/data_helper.dart';

import '../models/transaction_model.dart';

class TransactionController extends ChangeNotifier{

  List<TransactionModel>allTransactions=[];

  TransactionController(){
    getAllTransactions();
  }

  Future<List<TransactionModel>> getAllTransactions() async{
    allTransactions = await DataHelper.dataHelper.getAllTransaction();
    notifyListeners();
    return allTransactions;
  }

  Future<List<TransactionModel>> getFilterTransactions({required String type}) async{
    allTransactions = await DataHelper.dataHelper.getFilterTransaction(filter: type);
    notifyListeners();
    return allTransactions;
  }

  Future<int>deleteTransaction({required int id})async{
    notifyListeners();
    return await DataHelper.dataHelper.deleteTransaction(id: id);
  }

  Future<int> updateTransaction({required TransactionModel transactionModel})async{
    return await DataHelper.dataHelper.updateTransaction(transactionModel: transactionModel);
  }

}