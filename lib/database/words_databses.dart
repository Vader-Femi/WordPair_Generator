import 'package:english_words/english_words.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_pair_generator/database/word.dart';

class WordPairDatabase {
  static final WordPairDatabase instance = WordPairDatabase._init();

  static Database? _database;

  WordPairDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('words.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $tableWordPair (
    ${WordPairFields.id} $idType,
    ${WordPairFields.wordPair} $boolType,
    )
    ''');
  }

  Future<Word> create(Word word) async {
    final db = await instance.database;

    final id = await db.insert(tableWordPair, word.toJson());
    return word.copy(id: id);
  }

  Future<Word> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
        tableWordPair,
        columns: WordPairFields.values,
        where: '${WordPairFields.id} = ?',
        whereArgs: [id]
    );

    Future<List<Word>> readAllWordPairs() async {
      final db = await instance.database;

      final orderBy = '${WordPairFields.id} ASC';

      final result = await db.query(tableWordPair, orderBy: orderBy);

      return result.map((json) => Word.fromJson(json)).toList();
    }

    Future<int> update(Word word) async {
      final db = await instance.database;

      return db.update(
        tableWordPair,
        word.toJson(),
        where: '${WordPairFields.id} = ?',
        whereArgs: [word.id],
      );
    }

    Future<int> delete(int id) async {
      final db = await instance.database;

      return await db.delete(
          tableWordPair,
          where: '${WordPairFields.id} = ?',
          whereArgs:[id],
      );
    }

    if (maps.isNotEmpty) {
      return Word.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
