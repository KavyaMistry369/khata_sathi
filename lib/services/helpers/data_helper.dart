import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/transaction_model.dart';

class DataHelper {
  DataHelper._();

  static final DataHelper dataHelper = DataHelper._();

  late Database database;

  String transactionTable = "transaction";

  String trId = "id";
  String trName = "name";
  String trPhone = "phone";
  String trRemarks = "remarks";
  String trType = "type";
  String trTime = "time";
  String trAmt = "amount";
  String trDate = "date";

  initDataBase() async {
    String dbPath = await getDatabasesPath();
    String dbName = "Database3.db";

    String path = join(dbPath, dbName);

    database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE IF NOT EXISTS $transactionTable($trId INTEGER PRIMARY KEY AUTOINCREMENT,$trPhone TEXT,$trRemarks TEXT,$trAmt TEXT,$trType TEXT CHECK($trType IN("Credit","Debit")),$trName TEXT,$trDate TEXT,$trTime TEXT)');
      },
    );
  }

  Future<int> transactionInsert(
      {required TransactionModel transactionModel}) async {
    String query =
        "INSERT INTO $transactionTable($trRemarks,$trAmt,$trDate,$trType,$trTime,$trPhone,$trName) VALUES (?,?,?,?,?,?,?)";
    List args = [
      transactionModel.remark,
      transactionModel.amount,
      transactionModel.date,
      transactionModel.type,
      transactionModel.time,
      transactionModel.phone,
      transactionModel.name,
    ];
    int response = await database.rawInsert(query, args);
    log("=====================");
    log("=      $response    =");
    log("=====================");
    return response;
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    String query = "SELECT * FROM $transactionTable";

    List allData = (await database.rawQuery(query));

    List<TransactionModel> allTransactions =
        allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    return allTransactions;
  }
}
