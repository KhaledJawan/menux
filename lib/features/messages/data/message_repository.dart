import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'message_repository.g.dart';

class MessageRepository {
  MessageRepository(this._db);

  final AppDatabase _db;

  Stream<List<Message>> watchMessages() {
    final query = _db.select(_db.messages)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch();
  }

  Future<Message> create({
    required String senderName,
    String? recipientRole,
    required String title,
    required String body,
  }) async {
    final id = await _db.into(_db.messages).insert(
          MessagesCompanion.insert(
            senderName: senderName,
            recipientRole: Value(recipientRole),
            title: title,
            body: body,
          ),
        );
    return (_db.select(_db.messages)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> markRead(int id) async {
    await (_db.update(_db.messages)..where((t) => t.id.equals(id)))
        .write(const MessagesCompanion(isRead: Value(true)));
  }
}

@Riverpod(keepAlive: true)
MessageRepository messageRepository(Ref ref) {
  return MessageRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final messagesProvider = StreamProvider<List<Message>>((ref) {
  return ref.watch(messageRepositoryProvider).watchMessages();
});
