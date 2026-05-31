import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/category.dart';
import '../models/lyric.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(
      'lyrics_v4.db',
    ); // Bump version/new file for migration
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 5,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textNullable = 'TEXT';
    const boolType = 'INTEGER NOT NULL DEFAULT 0';
    const intType = 'INTEGER NOT NULL DEFAULT 0';

    await db.execute('''
CREATE TABLE categories (
  id $idType,
  name $textType,
  code $textType,
  updated_at $textType,
  is_synced $boolType,
  is_deleted $boolType
)
''');

    await db.execute('''
CREATE TABLE lyrics (
  id $idType,
  category_id $textType,
  title $textType,
  content $textType,
  updated_at $textType,
  is_synced $boolType,
  is_deleted $boolType,
  audio_url $textNullable,
  local_audio_path $textNullable,
  youtube_link $textNullable,
  sequence_number $intType
)
''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE lyrics ADD COLUMN audio_url TEXT');
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE lyrics ADD COLUMN local_audio_path TEXT');
    }
    if (oldVersion < 4) {
      await db.execute('ALTER TABLE lyrics ADD COLUMN youtube_link TEXT');
    }
    if (oldVersion < 5) {
      // Add code to categories
      await db.execute('ALTER TABLE categories ADD COLUMN code TEXT');
      // Populate code with simple logic (first 2 chars) for existing
      await db.execute(
        'UPDATE categories SET code = SUBSTR(name, 1, 2) WHERE code IS NULL',
      );
      // Ideally we want it NOT NULL, but SQLite ALTER TABLE is limited.
      // We can rely on app logic to handle it or enforce it later.

      // Add sequence_number to lyrics
      await db.execute(
        'ALTER TABLE lyrics ADD COLUMN sequence_number INTEGER NOT NULL DEFAULT 0',
      );
    }
  }

  // --- Categories ---

  Future<void> upsertCategory(Category category) async {
    final db = await instance.database;
    await db.insert('categories', {
      ...category.toMap(),
      'is_deleted': 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Category>> readAllCategories() async {
    final db = await instance.database;
    final result = await db.query(
      'categories',
      where: 'is_deleted = 0',
      orderBy: 'name ASC',
    );
    return result.map((json) => Category.fromMap(json)).toList();
  }

  Future<Category?> getCategory(String id) async {
    final db = await instance.database;
    final result = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Category.fromMap(result.first);
    }
    return null;
  }

  Future<List<Category>> getSyncedCategories() async {
    final db = await instance.database;
    final result = await db.query('categories', where: 'is_synced = 1');
    return result.map((json) => Category.fromMap(json)).toList();
  }

  Future<List<Category>> getUnsyncedCategories() async {
    final db = await instance.database;
    // Get both updated (is_synced=0) AND deleted (is_deleted=1) items that haven't been synced (implied by design, or we need to be careful)
    // Actually, when we soft delete, we set is_synced=0. So just fetching is_synced=0 is enough,
    // but we need to know if it's deleted to decide action in Repo.
    final result = await db.query('categories', where: 'is_synced = 0');
    return result.map((json) {
      // We need to handle is_deleted in fromMap or manually here.
      // For simplicity, I'll update fromMap later or just handle it here.
      // Let's assume Category model will get isDeleted field or we handle Map.
      // I will update Model next. For now, helper returns Maps? No, Models.
      // I need to update the Model to support isDeleted. AHH.
      // Okay, I will return models, but I need to update the Model class first or now.
      // I'll update the Model class to have isDeleted.
      return Category.fromMap(json);
    }).toList();
  }

  Future<void> softDeleteCategory(String id) async {
    final db = await instance.database;
    // Soft delete category
    await db.update(
      'categories',
      {
        'is_deleted': 1,
        'is_synced': 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    // Soft delete associated lyrics
    await db.update(
      'lyrics',
      {
        'is_deleted': 1,
        'is_synced': 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'category_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> hardDeleteCategory(String id) async {
    final db = await instance.database;
    await db.delete('lyrics', where: 'category_id = ?', whereArgs: [id]);
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // --- Lyrics ---

  Future<void> upsertLyric(Lyric lyric) async {
    final db = await instance.database;
    await db.insert('lyrics', {
      ...lyric.toMap(),
      'is_deleted': 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Lyric>> readLyricsByCategory(String categoryId) async {
    final db = await instance.database;
    final result = await db.query(
      'lyrics',
      where: 'category_id = ? AND is_deleted = 0',
      whereArgs: [categoryId],
      orderBy: 'sequence_number ASC',
    );
    return result.map((json) => Lyric.fromMap(json)).toList();
  }

  Future<List<Lyric>> readAllLyrics() async {
    final db = await instance.database;
    final result = await db.query('lyrics', where: 'is_deleted = 0');
    return result.map((json) => Lyric.fromMap(json)).toList();
  }

  Future<Lyric?> getLyricById(String id) async {
    final db = await instance.database;
    final result = await db.query('lyrics', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Lyric.fromMap(result.first);
    }
    return null;
  }

  Future<List<Lyric>> getSyncedLyrics() async {
    final db = await instance.database;
    final result = await db.query('lyrics', where: 'is_synced = 1');
    return result.map((json) => Lyric.fromMap(json)).toList();
  }

  Future<List<Lyric>> getUnsyncedLyrics() async {
    final db = await instance.database;
    final result = await db.query('lyrics', where: 'is_synced = 0');
    return result.map((json) => Lyric.fromMap(json)).toList();
  }

  Future<void> softDeleteLyric(String id) async {
    final db = await instance.database;
    await db.update(
      'lyrics',
      {
        'is_deleted': 1,
        'is_synced': 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> hardDeleteLyric(String id) async {
    final db = await instance.database;
    await db.delete('lyrics', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Lyric>> searchLyrics(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'lyrics',
      where: '(title LIKE ? OR content LIKE ?) AND is_deleted = 0',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'title ASC',
    );
    return result.map((json) => Lyric.fromMap(json)).toList();
  }

  Future<void> markCategorySynced(String id) async {
    final db = await instance.database;
    await db.update(
      'categories',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markLyricSynced(String id) async {
    final db = await instance.database;
    await db.update(
      'lyrics',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getMaxSequenceNumber(String categoryId) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT MAX(sequence_number) as max_seq FROM lyrics WHERE category_id = ?',
      [categoryId],
    );
    if (result.isNotEmpty && result.first['max_seq'] != null) {
      return result.first['max_seq'] as int;
    }
    return 0;
  }
}
