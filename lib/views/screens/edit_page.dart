import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata_sathi/controllers/transaction_controller.dart';
import 'package:khata_sathi/models/transaction_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/page_controller.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int ;
    TransactionModel transactionModel = Provider.of<TransactionController>(context).allTransactions[index];
    return Consumer<Pagecontroller>(
      builder: (context,p,_) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text("Edit Page"),
          ),
          body: Padding(padding: const EdgeInsets.all(16),child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onChanged: (value){
                      transactionModel.name=value;
                    },
                    initialValue: transactionModel.name,
                    decoration: const  InputDecoration(
                      label: Text("Name"),
                    ),
                  ),
                 const SizedBox(height: 20,),
                  TextFormField(
                    onChanged: (value){
                      transactionModel.phone=value;
                    },
                    initialValue: transactionModel.phone,
                    decoration: const InputDecoration(
                      label:  Text("Phone"),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onChanged: (value){
                      transactionModel.remark=value;
                    },
                    initialValue: transactionModel.remark,
                    decoration: const InputDecoration(
                      label: Text("Remark"),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    initialValue: transactionModel.amount,
                    onChanged: (value){
                      transactionModel.amount=value;
                    },
                    decoration:const InputDecoration(
                      label:  Text("Amount"),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  CupertinoSlidingSegmentedControl(
                    groupValue: p.segment,
                    onValueChanged: (type? value) {
                      p.changeType(val: value!);
                      transactionModel.type = value.name;
                    },
                    children: const {
                      type.credit: Text(
                        "Credit",
                        style: TextStyle(fontSize: 20),
                      ),
                      type.debit: Text(
                        "Debit",
                        style: TextStyle(fontSize: 20),
                      )
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () async {
                            DateTime? d = await showDatePicker(
                                context: context,
                                initialDate: p.mydate,
                                firstDate: DateTime(1947),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 1),
                                ),
                                initialEntryMode:
                                DatePickerEntryMode.calendarOnly,
                                initialDatePickerMode: DatePickerMode.day,
                                onDatePickerModeChange: (date) =>
                                    p.changeDate(date: p.mydate));
                            transactionModel.date = d.toString();
                          },
                          color: (Provider.of<Pagecontroller>(context).isDark)? CupertinoColors.systemIndigo:CupertinoColors.activeBlue,
                          iconSize: 35,
                          icon: const Icon(Icons.calendar_month)),
                      IconButton(
                          onPressed: () async {
                            TimeOfDay? t = await showTimePicker(
                                context: context, initialTime: p.timeMy);
                            DateTime d = DateTime(0, 0, 0, t!.hour, t.minute);
                            p.changeTime(time: d.toLocal());
                            transactionModel.time = t.toString();
                          },
                          color: (Provider.of<Pagecontroller>(context).isDark)? CupertinoColors.systemIndigo:CupertinoColors.activeBlue,
                          iconSize: 35,
                          icon: const Icon(Icons.access_alarm_outlined)),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(onPressed: (){
                        Provider.of<TransactionController>(context,listen: false).updateTransaction(transactionModel: transactionModel);
                        Navigator.of(context).pop();
                      },label: const Text("Update"),icon: const Icon(Icons.edit_note),),
                      ElevatedButton.icon(onPressed: (){
                        Navigator.of(context).pop();
                      },label: const Text("Cancel"),icon: const Icon(Icons.cancel),),
                    ],
                  )
                ],
              ),
            ),
          ),),
        );
      }
    );
  }
}
