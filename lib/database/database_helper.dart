import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

import '../model/my_transaction.dart';

class DatabaseHelper {
  static const _databaseVersion = 1;
  static const _databaseName = 'MyMyTransactions.db';

  static const transactionsTable = 'transactions';
  static const transactionId = 'id';
  static const transactionAmount = 'amount';
  static const transactionPhone = 'phone';

  static late BriteDatabase _streamDatabase;

  static Database? _database;
  static var lock = Lock();

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $transactionsTable (
      $transactionId INTEGER PRIMARY KEY,
      $transactionAmount REAL,
      $transactionPhone TEXT
      )''');
  }

  Future<Database> _initDatabase() async {

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    Sqflite.setDebugModeOn(true);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    await lock.synchronized(() async {

      if (_database == null) {

        _database = await _initDatabase();

        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }
  Future<BriteDatabase> get streamDatabase async {
// 2
    await database;
    return _streamDatabase;
  }

  List<MyTransaction> parseMyTransactions(List<Map<String, dynamic>> transactionList)
  {
    final transactions = <MyTransaction>[];
// 1
    for (var transactionMap in transactionList) {
// 2
      final transaction = MyTransaction.fromJson(transactionMap);
// 3
      transactions.add(transaction);
    }
// 4
    return transactions;
  }
  Future<List<MyTransaction>> findAllMyTransactions() async {
// 1
    final db = await instance.streamDatabase;
// 2
    final transactionsList = await db.query(transactionsTable);
// 3
    final recipes = parseMyTransactions(transactionsList);
    return recipes;
  }
  Stream<List<MyTransaction>> watchAllMyTransaction() async* {
    final db = await instance.streamDatabase;
// 1
    yield* db
// 2
        .createQuery(transactionsTable)
// 3
        .mapToList((row) => MyTransaction.fromJson(row));
  }
  Future<int> insert(String table, Map<String, dynamic> row) async
  {
    final db = await instance.streamDatabase;
// 2
    return db.insert(table, row);
  }
  void close() {
    _streamDatabase.close();
  }
}
