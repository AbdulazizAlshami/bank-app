import 'package:flutter/material.dart';

import '../model/my_transaction.dart';

class Reposts extends StatelessWidget {
  Reposts({Key? key}) : super(key: key);
  final List<MyTransaction> reportsList = [
    MyTransaction(id: 1, amount: 6500.00, phone: "+967771815121"),
    MyTransaction(id: 2, amount: 9800.00, phone: "+967777442639"),
    MyTransaction(id: 3, amount: 2000.00, phone: "+967772251650"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => Card(
            child: Container(
              height: 80,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Flexible(
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Center(child: Text(reportsList[index].id.toString())),
                    ),
                  ),
                  Flexible(child: SizedBox(width: 20,)),
                  Flexible(
                    flex: 9,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: Text("phone: ${reportsList[index].phone}")),
                        Flexible(child: Text("Amount: ${reportsList[index].amount}")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
