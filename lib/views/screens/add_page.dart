import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata_sathi/controllers/page_controller.dart';
import 'package:khata_sathi/models/transaction_model.dart';
import 'package:khata_sathi/services/helpers/data_helper.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionModel transactionModel = TransactionModel.init();

    return Consumer<Pagecontroller>(builder: (context, p, _) {
      return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Stepper(
                physics: const ScrollPhysics(),
                currentStep: p.currentSteps,
                onStepContinue: () {
                  p.stepForward();
                },
                onStepTapped: (index) => p.stepTap(index: index),
                onStepCancel: () {
                  p.stepBackward();
                },
                steps: <Step>[
                  Step(
                    state: p.myState(index: 1),
                    isActive: true,
                    title: const Text(
                      'Name',
                      style: TextStyle(),
                    ),
                    content: TextFormField(
                      onChanged: (val) {
                        transactionModel.name = val;
                      },
                      style: const TextStyle(),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "name",
                      ),
                    ),
                  ),
                  Step(
                    state: p.myState(index: 2),
                    isActive: true,
                    title: const Text(
                      'Phone',
                      style: TextStyle(),
                    ),
                    content: TextFormField(
                      onChanged: (val) {
                        transactionModel.phone = val;
                      },
                      style: const TextStyle(),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "phone",
                      ),
                    ),
                  ),
                  Step(
                    state: p.myState(index: 3),
                    isActive: true,
                    title: const Text(
                      'Remark',
                      style: TextStyle(),
                    ),
                    content: TextFormField(
                      onChanged: (val) {
                        transactionModel.remark = val;
                      },
                      style: const TextStyle(),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "remark",
                      ),
                    ),
                  ),
                  Step(
                    state: p.myState(index: 4),
                    isActive: true,
                    title: const Text(
                      'Amount',
                      style: TextStyle(),
                    ),
                    content: TextFormField(
                      onChanged: (val) {
                        transactionModel.amount = val;
                      },
                      style: const TextStyle(),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter the amount";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "amount",
                      ),
                    ),
                  ),
                  Step(
                    state: p.myState(index: 5),
                    isActive: true,
                    title: const Text(
                      'Type',
                      style: TextStyle(),
                    ),
                    content: CupertinoSlidingSegmentedControl(
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
                  ),
                  Step(
                    state: p.myState(index: 6),
                    isActive: true,
                    title: const Text(
                      'Time and Date',
                      style: TextStyle(),
                    ),
                    content: Row(
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
                            color: CupertinoColors.activeBlue,
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
                            color: CupertinoColors.activeBlue,
                            iconSize: 35,
                            icon: const Icon(Icons.access_alarm_outlined))
                      ],
                    ),
                  ),
                  Step(
                      state: p.myState(index: 7),
                      isActive: true,
                      title: const Text('Done'),
                      content: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              int id = await DataHelper.dataHelper
                                  .transactionInsert(
                                      transactionModel: transactionModel);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        "Transaction Created $id",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )));
                            },
                            child: const Text("Save"),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Cancel"),
                          ),
                        ],
                      )),
                ]),
          ));
    });
  }
}
