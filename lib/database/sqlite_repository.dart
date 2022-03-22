

import '../model/my_transaction.dart';
import 'database_helper.dart';

class SqliteRepository {
// 3
  final dbHelper = DatabaseHelper.instance;
  Stream<List<MyTransaction>> watchAllTransaction() {
    return dbHelper.watchAllMyTransaction();
  }

  Future<int> insertTransaction(MyTransaction myTransaction) {
    return Future(() async {
      final id = await dbHelper.insert(DatabaseHelper.transactionsTable,myTransaction.toMap());
      return id;
    });
  }
  Future init() async {
// 1
    await dbHelper.database;
    return Future.value();
  }
  void close() {
// 2
    dbHelper.close();
  }}
