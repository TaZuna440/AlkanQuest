import 'package:drift/drift.dart';
import 'challenges_table.dart';

class SavingsRecords extends Table {
  TextColumn get id => text()();
  TextColumn get challengeId =>
      text().references(Challenges, #id, onDelete: KeyAction.cascade)();
  IntColumn get amountCents => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get proofPath => text().nullable()();
  IntColumn get proofWidth => integer().nullable()();
  IntColumn get proofHeight => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
