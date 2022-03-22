import 'package:flutter/material.dart';


import '../database/sqlite_repository.dart';
import '../model/my_transaction.dart';

class TransReport extends StatelessWidget {
  TransReport({Key? key}) : super(key: key);
  final repository = SqliteRepository();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder<List<MyTransaction>>(
          stream: repository.watchAllTransaction(),
          builder:(context, AsyncSnapshot<List<MyTransaction>> snapshot){
            if (snapshot.connectionState == ConnectionState.active) {
              final reportsList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: reportsList.length,
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
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(child: Text(reportsList[index].phone)),
                              Flexible(child: Text("Amount: ${reportsList[index].amount}")),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
