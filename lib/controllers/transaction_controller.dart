import 'package:flutter/material.dart';
import 'package:khata_sathi/controllers/page_controller.dart';
import 'package:khata_sathi/services/helpers/data_helper.dart';

import '../models/transaction_model.dart';

class TransactionController extends ChangeNotifier{

  List<TransactionModel>allTransactions=[];
  List<TransactionModel>allFilterTransactions=[];
  List<TransactionModel>allTodayDebit=[];
  List<TransactionModel>allDebitAmount=[];
  List<TransactionModel>allCreditAmount=[];
  List<TransactionModel>allTodayCredit=[];
  int totalDebitAmount = 0;
  int totalCreditAmount = 0;


  TransactionController(){
    getAllTransactions();
    getTodayDebit();
    getTodayCredit();
    calculateDebit();
    calculateCredit();
  }

  calculateDebit()async{

    allDebitAmount = await DataHelper.dataHelper.calculateDebit();
    int i =0;
    for(i;i<allDebitAmount.length;i++){
      TransactionModel transactionModel = allDebitAmount[i];
      totalDebitAmount+=int.parse(transactionModel.amount!);
    }
    print(totalDebitAmount);
  }

  calculateCredit()async{

    allCreditAmount = await DataHelper.dataHelper.calculateCredit();
    int i =0;
    for(i;i<allCreditAmount.length;i++){
      TransactionModel transactionModel = allCreditAmount[i];
      totalCreditAmount+=int.parse(transactionModel.amount!);
    }
    print(totalCreditAmount);
  }

  Future<List<TransactionModel>> getTodayDebit()async{
   allTodayDebit=await DataHelper.dataHelper.getTodayDebit();
   return allTodayDebit;
  }

  Future<List<TransactionModel>> getTodayCredit()async{
    allTodayCredit=await DataHelper.dataHelper.getTodayCredit();
    return allTodayCredit;
  }

  Future<List<TransactionModel>> getAllTransactions() async{
    allTransactions = await DataHelper.dataHelper.getAllTransaction();
    notifyListeners();
    return allTransactions;
  }

  Future<List<TransactionModel>> getFilterTransactions({required String type}) async{

    if(type==filter.all.name){
      allTransactions = await DataHelper.dataHelper.getFilterTransaction(filter: type);
      notifyListeners();
      return allTransactions;
    }
    else{
      allTransactions = await DataHelper.dataHelper.getFilterTransaction(filter: type);
      notifyListeners();
      return allTransactions;
    }
  }

  Future<int>deleteTransaction({required int id})async{
    notifyListeners();
    return await DataHelper.dataHelper.deleteTransaction(val: id);
  }

  Future<int> updateTransaction({required TransactionModel transactionModel})async{
    return await DataHelper.dataHelper.updateTransaction(transactionModel: transactionModel);
  }

}