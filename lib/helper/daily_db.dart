import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DailyDB {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(path.join(dbPath, 'daily.db'), version: 1,
        onCreate: (db, v) async {
      await db.execute('''CREATE TABLE Users 
        (
          id INTEGER,
          token TEXT,
          name TEXT, 
          user_pic TEXT
         )
      ''');
      await db.execute(
          'CREATE TABLE Daily (id INTEGER PRIMARY KEY, name TEXT, type TEXT, dosage INTEGER, situation TEXT)');
      await db.execute(''' 
      CREATE TABLE water (
        hour INTEGER,
        minute INTEGER,
        day INTEGER
      )
      ''');
      await db.execute('''
      CREATE TABLE chat (
        text TEXT,
        userHasText INTEGER
      )
      ''');
      await db.execute('''
        CREATE TABLE recipes (
          title TEXT,
          image TEXT,
          ingredients_id INTEGER,
          meal_type TEXT,
          enerc_kcal REAL,
          cuisine_type TEXT,
          recipe_url TEXT
        )
      ''');
      await db.execute('''
          CREATE TABLE ingredients_one (
            id INTEGER,
            name TEXT
          )
        ''');
      await db.execute('''
          CREATE TABLE ingredients_lines (
            id INTEGER,
            name TEXT
          )
        ''');
      await db.execute(''' 
        CREATE TABLE ingredients_two (
          name TEXT,
          category TEXT,
          is_selected INTEGER
        )
      ''');
      await db.execute('''
      CREATE TABLE medicine (
        title TEXT,
        img TEXT,
        price INTEGER,
        manufacturer TEXT
      )
''');
    });
  }

  static Future<void> deleteWater() async {
    final sq = await DailyDB.database();
    await sq.rawDelete('DELETE FROM water');
  }

  static Future<bool> isMedicineExists(String title) async {
    final sq = await DailyDB.database();
    List<Map<String, dynamic>> data =
        await sq.rawQuery('SELECT * FROM medicine WHERE title =? ', [title]);
    if (data.isEmpty) {
      return false;
    }
    return true;
  }

  static Future<bool> isRecipeExists(String title) async {
    final sq = await DailyDB.database();
    List<Map<String, dynamic>> data =
        await sq.rawQuery('SELECT * FROM recipes WHERE title =? ', [title]);
    if (data.isEmpty) {
      return false;
    }
    return true;
  }

  static Future<void> deleteChat() async {
    final sq = await DailyDB.database();
    await sq.rawDelete('DELETE FROM chat');
  }

  static Future<int> deleteDailyData(String name) async {
    final sq = await DailyDB.database();
    int rowsAffected =
        await sq.rawDelete('DELETE FROM Daily WHERE name = ? ', [name]);
    return rowsAffected;
  }

  static Future<List<Map<String, dynamic>>?> getdata(String table) async {
    final sq = await DailyDB.database();
    return await sq.query(table);
  }

  static Future<void> deleteData(String table) async {
    final sq = await DailyDB.database();
    await sq.delete(table);
  }

  static Future<void> deleteDataClause(int day) async {
    final sq = await DailyDB.database();
    await sq.rawDelete('DELETE FROM water WHERE day =? ', ['$day']);
  }

  static Future<void> insertData(
      String table, Map<String, dynamic> values) async {
    final sq = await DailyDB.database();
    await sq.insert(table, values);
  }

  static Future<void> updateData(
      String table, int where, Map<String, dynamic> values) async {
    final sq = await DailyDB.database();
    await sq.rawUpdate(
        'UPDATE Users SET id = ?, token = ?, name = ?, user_pic = ?  WHERE id = ?',
        [
          values['id'],
          values['token'],
          values['name'],
          values['user_pic'],
          values['id']
        ]);
  }
}
