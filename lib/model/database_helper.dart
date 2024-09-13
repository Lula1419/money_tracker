
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:money_tacker/model/transaction.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();
  

  Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath =await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async{
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL,
        date TEXT,
        isExpense INTEGER,
        type TEXT
      )
      ''');
  }

  Future<int> insertTransaction(FinancialTransaction transaction) async{
    final db =await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<void> insertTransactions(List<FinancialTransaction> transactions) async {
    final db = await instance.database;
    Batch batch = db.batch();
    for (var transaction in transactions) {
      batch.insert('transactions', transaction.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<FinancialTransaction>> getTransactions() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    print('Raw data from database: $maps'); // Para depuración
    return List.generate(maps.length, (i) {
      print('Converting map: ${maps[i]}'); // Para depuración
      return FinancialTransaction.fromMap(maps[i]);
  });}


}