import 'package:flutter/material.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/services/db_service.dart';

class MessagingProvider with ChangeNotifier {
  List<MessageModel> _chats = [];
  List<MessageModel> get chats => _chats;

  updateChats() async {
    _chats = await DBProvider.db.getChats();
    notifyListeners();
  }

  addMessageToChat(MessageModel message) async {
    await DBProvider.db.insertChat(message);
    updateChats();
  }

  updateChatMessage(MessageModel message) async {
    await DBProvider.db.updateMessage(message);
    updateChats();
  }

  Future<void> clearDatabase() async {
    await DBProvider.db.clearDatabase();
    _chats = [];
    updateChats();
  }
}