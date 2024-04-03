import 'dart:developer';

class TransactionModel {
   int? id;
   String? name;
   String? phone;
   String? remark;
   String? amount;
   String? type;
   String? date;
   String? time;

  TransactionModel(
      {
        this.id,
       this.name,
       this.phone,
       this.remark,
       this.amount,
       this.type,
       this.date,
       this.time});

   TransactionModel.init() {
     log("Empty transaction initialized...");
   }

  factory TransactionModel.fromMap({required Map data}) {
    return TransactionModel(
        id: data['id'],
        name: data['name'],
        phone: data['phone'],
        remark: data['remark'],
        amount: data['amount'],
        type: data['type'],
        date: data['date'],
        time: data['time']);
  }
}
