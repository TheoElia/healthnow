
import 'dart:io';

import 'package:healthnowapp/src/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  late final Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _open();
    return _database;
  }

  Future _open() async {
    print("creating db");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "healthnow1.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      return db.execute(
        "CREATE TABLE chats(id INTEGER PRIMARY KEY, msg TEXT, msgId TEXT, receiverId TEXT, senderId TEXT)",
      );
    });
  }

  Future<void> insertChat(MessageModel message) async {
    final Database db = await database;

    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MessageModel>> getChats() async {
    final Database db = await database;

    // Query the table for all The Chat.
    final List<Map<String, dynamic>> maps = await db.query('messages');

    // Convert the List<Map<String, dynamic> into a List<Chat>.
    return List.generate(maps.length, (i) {
      return MessageModel(
        msgId: maps[i]['msgId'],
        msg: maps[i]['msg'],
        senderId: maps[i]['senderId'],
        receiverId: maps[i]['receiverId'],
      );
    });
  }

  Future<void> updateMessage(MessageModel message) async {
    final db = await database;
    await db.update(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      // Ensure that the Chat has a matching id.
      where: "msgId = ?",
      // Pass the Chat's id as a whereArg to prevent SQL injection.
      whereArgs: [message.msgId],
    );
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.rawQuery("DELETE FROM chats");
  }

}