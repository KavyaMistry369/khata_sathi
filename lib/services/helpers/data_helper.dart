import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/transaction_model.dart';

class DataHelper {
  DataHelper._();

  static final DataHelper dataHelper = DataHelper._();

  Database? database;

  String transactionTable = "record";

  String trId = "id";
  String trName = "name";
  String trPhone = "phone";
  String trRemark = "remark";
  String trType = "type";
  String trTime = "time";
  String trAmt = "amount";
  String trDate = "date";

  String formatDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<Database?> initDataBase() async {
    String dbPath = await getDatabasesPath();
    String dbName = "Database3.db";

    String path = join(dbPath, dbName);

    database ??= await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE IF NOT EXISTS $transactionTable($trId INTEGER PRIMARY KEY AUTOINCREMENT,$trPhone TEXT,$trRemark TEXT,$trAmt TEXT,$trType TEXT,$trName TEXT,$trDate TEXT,$trTime TEXT)');
        log("Table Created");
      },
    );
    return database;
  }

  Future<int> transactionInsert(
      {required TransactionModel transactionModel}) async {
    await initDataBase();
    String query =
        "INSERT INTO $transactionTable($trName,$trPhone,$trAmt,$trRemark,$trTime,$trDate,$trType) VALUES (?,?,?,?,?,?,?)";
    List args = [
      transactionModel.name,
      transactionModel.phone,
      transactionModel.amount,
      transactionModel.remark,
      transactionModel.time,
      transactionModel.date,
      transactionModel.type,
    ];

    log("=====================");
    log("=      $query       =");
    log("=====================");

    int response = await database!.rawInsert(query, args);
    log("=====================");
    log("=      $args        =");
    log("=====================");
    return response;
  }


  Future<List<TransactionModel>> getAllTransaction() async {
    await initDataBase();
    String query = "SELECT * FROM $transactionTable";

    List allData = (await database!.rawQuery(query));

    List<TransactionModel> allTransactions =
        allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    log(formatDate);

    return allTransactions;
  }

  Future<List<TransactionModel>> getFilterTransaction({required String filter}) async {
    await initDataBase();
    String query = "SELECT * FROM $transactionTable WHERE $trType='$filter'";

    List allData = (await database!.rawQuery(query));

    List<TransactionModel> allTransactions =
    allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    print("---------------");
    print(allTransactions);

    return allTransactions;
  }

  Future<List<TransactionModel>> getTodayDebit() async {
    await initDataBase();
    String query = "SELECT * FROM $transactionTable WHERE $trDate='$formatDate' AND $trType='debit'";

    List allData = (await database!.rawQuery(query));

    List<TransactionModel> allTodayDebit =
    allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    print("---------------");
    print(allTodayDebit);

    return allTodayDebit;
  }

  Future<List<TransactionModel>> calculateDebit() async {
    await initDataBase();
    String query = "SELECT amount FROM $transactionTable WHERE $trType='debit'";

    List allData = (await database!.rawQuery(query));

    List<TransactionModel> allDebit =
    allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    print("---------------");
    print(allDebit);
    print("---------------");

    return allDebit;
  }

  Future<List<TransactionModel>> calculateCredit() async {
    await initDataBase();
    String query = "SELECT amount FROM $transactionTable WHERE $trType='credit'";

    List allData = (await database!.rawQuery(query));

    List<TransactionModel> allCredit =
    allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    print("---------------");
    print(allCredit);
    print("---------------");

    return allCredit;
  }

  Future<List<TransactionModel>> getTodayCredit() async {
    await initDataBase();
    String query = "SELECT * FROM $transactionTable WHERE $trDate='$formatDate' AND  $trType='credit'";

    List allData = (await database!.rawQuery(query));

    List<TransactionModel> allTodayCredit =
    allData.map((e) => TransactionModel.fromMap(data: e)).toList();

    print("---------------");
    print(allTodayCredit);

    return allTodayCredit;
  }

  Future<int> updateTransaction(
      {required TransactionModel transactionModel}) async {
    await initDataBase();
    String query =
        "UPDATE $transactionTable SET $trName=?,$trPhone=?,$trAmt=?,$trRemark=?,$trTime=?,$trDate=?,$trType=? WHERE $trId=${transactionModel.id}";
    List args = [
      transactionModel.name,
      transactionModel.phone,
      transactionModel.amount,
      transactionModel.remark,
      transactionModel.time,
      transactionModel.date,
      transactionModel.type,
    ];

    log("Update Done");

    return database!.rawUpdate(query, args);
  }

  Future<int> deleteTransaction({required int val}) async {
    await initDataBase();
    String query = "DELETE FROM $transactionTable WHERE $trId == $val";

    int i = await database!.rawDelete(query);

    log(i.toString());

    return i;
  }
}
