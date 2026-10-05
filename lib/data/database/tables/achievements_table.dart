import 'package:drift/drift.dart';

class Achievements extends Table {
  TextColumn get id => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameFil => text()();
  TextColumn get descriptionEn => text()();
  TextColumn get descriptionFil => text()();
  TextColumn get icon => text()();
  IntColumn get xpReward => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
