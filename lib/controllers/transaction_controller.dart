import 'package:flutter/material.dart';
import 'package:khata_sathi/services/helpers/data_helper.dart';

import '../models/transaction_model.dart';

class TransactionController extends ChangeNotifier{

  List<TransactionModel>allTransactions=[];

  List<TransactionModel> get getAllTransactions {
    return allTransactions;
  }

}