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
    _database = await _initDB('lyrics_v4.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 6,
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

    await db.execute('''
CREATE TABLE pending_access_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lyric_id TEXT NOT NULL,
  accessed_at TEXT NOT NULL,
  is_flushed INTEGER NOT NULL DEFAULT 0
)
''');
    await db.execute(
      'CREATE INDEX idx_pending_access_flush ON pending_access_events (is_flushed, id)',
    );
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
      await db.execute('ALTER TABLE categories ADD COLUMN code TEXT');
      await db.execute(
        'UPDATE categories SET code = SUBSTR(name, 1, 2) WHERE code IS NULL',
      );
      await db.execute(
        'ALTER TABLE lyrics ADD COLUMN sequence_number INTEGER NOT NULL DEFAULT 0',
      );
    }
    if (oldVersion < 6) {
      await db.execute('''
CREATE TABLE pending_access_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lyric_id TEXT NOT NULL,
  accessed_at TEXT NOT NULL,
  is_flushed INTEGER NOT NULL DEFAULT 0
)
''');
      await db.execute(
        'CREATE INDEX idx_pending_access_flush ON pending_access_events (is_flushed, id)',
      );
    }
  }

  // --- Categories Operations ---

  Future<void> upsertCategory(Category category) async {
    final db = await instance.database;
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
    final result = await db.query('categories', where: 'is_synced = 0');
    return result.map((json) => Category.fromMap(json)).toList();
  }

  Future<void> softDeleteCategory(String id) async {
    final db = await instance.database;
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

  // --- Lyrics Operations ---

  Future<void> upsertLyric(Lyric lyric) async {
    final db = await instance.database;
    await db.insert(
      'lyrics',
      lyric.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future<int> enqueuePendingAccessEvent(String lyricId) async {
    final db = await instance.database;
    return db.insert('pending_access_events', {
      'lyric_id': lyricId,
      'accessed_at': DateTime.now().toIso8601String(),
      'is_flushed': 0,
    });
  }

  Future<List<Map<String, dynamic>>> getUnflushedAccessEvents() async {
    final db = await instance.database;
    return db.query(
      'pending_access_events',
      where: 'is_flushed = 0',
      orderBy: 'id ASC',
    );
  }

  Future<void> markAccessEventFlushed(int id) async {
    final db = await instance.database;
    await db.update(
      'pending_access_events',
      {'is_flushed': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> countPendingAccessEvents() async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS c FROM pending_access_events WHERE is_flushed = 0',
    );
    return Sqflite.firstIntValue(result) ?? 0;
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
